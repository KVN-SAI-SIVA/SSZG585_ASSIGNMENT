import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task_comment.dart';
import '../models/task.dart';

class CommentService {
  // Create a comment attached to a Task
  static Future<ParseResponse> createComment({
    required Task task,
    required String text,
  }) async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      final resp = ParseResponse();
      resp.success = false;
      resp.statusCode = 401;
      resp.error = ParseError(message: 'User not authenticated', code: 401);
      return resp;
    }

    final comment = TaskComment()
      ..text = text
      ..createdBy = currentUser
      ..task = task;

    return await comment.save();
  }

  // Get comments for a task (ordered ascending by createdAt)
  static Future<List<TaskComment>> getCommentsForTask(Task task) async {
    final query = QueryBuilder<TaskComment>(TaskComment())
      ..whereEqualTo(TaskComment.keyTask, task)
      ..orderByAscending('createdAt');

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<TaskComment>();
    }
    return [];
  }

  // Update a comment's text
  static Future<ParseResponse> updateComment({
    required TaskComment comment,
    required String text,
  }) async {
    comment.text = text;
    return await comment.save();
  }

  // Delete a comment
  static Future<ParseResponse> deleteComment(TaskComment comment) async {
    return await comment.delete();
  }
}
