import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task.dart';
import 'comment_service.dart';

class TaskService {
  // Create a new task
  static Future<ParseResponse> createTask({
    required String title,
    required String description,
    String status = 'New',
    DateTime? startDate,
    DateTime? endDate,
    String? discussion,
  }) async {
    final currentUser = (await ParseUser.currentUser()) as ParseUser?;

    if (currentUser == null) {
      final resp = ParseResponse();
      resp.success = false;
      resp.statusCode = 401;
      resp.error = ParseError(message: 'User not authenticated', code: 401);
      return resp;
    }

    final task = Task()
      ..title = title
      ..description = description
      ..isCompleted = status == 'Closed'
      ..status = status
      ..startDate = startDate
      ..endDate = endDate
      ..discussion = discussion
      ..createdBy = currentUser;

    final saveResp = await task.save();

    // If the task saved successfully and there's an initial discussion text,
    // create a TaskComment to seed the threaded discussion.
    if (saveResp.success &&
        discussion != null &&
        discussion.trim().isNotEmpty) {
      try {
        await CommentService.createComment(task: task, text: discussion.trim());
      } catch (_) {
        // Non-fatal: creating the initial comment failed; return the task save response anyway.
      }
    }

    return saveResp;
  }

  // Get all tasks for the current user
  static Future<List<Task>> getAllTasks({String? status}) async {
    final currentUser = (await ParseUser.currentUser()) as ParseUser?;

    if (currentUser == null) {
      return [];
    }

    final queryBuilder = QueryBuilder<Task>(Task())
      ..whereEqualTo(Task.keyCreatedBy, currentUser)
      ..orderByDescending('createdAt');

    if (status != null && status.isNotEmpty) {
      queryBuilder.whereEqualTo(Task.keyStatus, status);
    }

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results!.cast<Task>();
    }
    return [];
  }

  // Update a task
  static Future<ParseResponse> updateTask({
    required Task task,
    String? title,
    String? description,
    bool? isCompleted,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? discussion,
  }) async {
    if (title != null) task.title = title;
    if (description != null) task.description = description;
    if (isCompleted != null) task.isCompleted = isCompleted;
    if (status != null) task.status = status;
    if (startDate != null) task.startDate = startDate;
    if (endDate != null) task.endDate = endDate;
    if (discussion != null) task.discussion = discussion;

    return await task.save();
  }

  // Delete a task
  static Future<ParseResponse> deleteTask(Task task) async {
    return await task.delete();
  }

  // Toggle task completion status
  static Future<ParseResponse> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    return await task.save();
  }

  // Search tasks by title
  static Future<List<Task>> searchTasks(String query) async {
    final currentUser = (await ParseUser.currentUser()) as ParseUser?;

    if (currentUser == null) {
      return [];
    }

    final queryBuilder = QueryBuilder<Task>(Task())
      ..whereEqualTo(Task.keyCreatedBy, currentUser)
      ..whereContains(Task.keyTitle, query, caseSensitive: false)
      ..orderByDescending('createdAt');

    // Support optional status filter if provided in the query string format: "status:Active"
    // Caller can pass special query or use dedicated search with status parameter.

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results!.cast<Task>();
    }
    return [];
  }
}
