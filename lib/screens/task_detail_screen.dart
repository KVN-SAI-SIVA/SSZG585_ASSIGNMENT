import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task_comment.dart';
import '../services/comment_service.dart';
import 'add_edit_task_screen.dart';
import '../widgets/app_background.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  List<TaskComment> _comments = [];
  final _commentController = TextEditingController();
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    final comments = await CommentService.getCommentsForTask(widget.task);
    setState(() => _comments = comments);
  }

  Future<void> _postComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() => _isPosting = true);
    final resp =
        await CommentService.createComment(task: widget.task, text: text);
    setState(() => _isPosting = false);
    if (!mounted) return;
    if (resp.success) {
      _commentController.clear();
      _loadComments();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Comment added')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resp.error?.message ?? 'Failed to add comment'),
          backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AddEditTaskScreen(task: task)));
              // after edit, pop to home and we could refresh if needed. For now, simply reload comments.
              _loadComments();
            },
            tooltip: 'Edit task',
          ),
        ],
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(task.title ?? 'Untitled',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(task.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Row(children: [
                Chip(
                    label: Text(
                        task.status ?? (task.isCompleted ? 'Closed' : 'New'))),
                const SizedBox(width: 12),
                if (task.startDate != null)
                  Text(
                      'Start: ${task.startDate!.toLocal().toString().split(' ')[0]}'),
                const SizedBox(width: 8),
                if (task.endDate != null)
                  Text(
                      'End: ${task.endDate!.toLocal().toString().split(' ')[0]}'),
              ]),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Discussion',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              for (final c in _comments) ...[
                ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: Text(c.text ?? ''),
                  subtitle: Text(c.createdAt != null
                      ? c.createdAt!.toLocal().toString()
                      : ''),
                  trailing: FutureBuilder<ParseUser?>(
                    future: ParseUser.currentUser()
                        .then((user) => user as ParseUser?),
                    builder: (context, snap) {
                      final current = snap.data;
                      final isOwner = current != null &&
                          c.createdBy?.objectId == current.objectId;
                      if (!isOwner) return const SizedBox.shrink();
                      return PopupMenuButton<String>(
                        onSelected: (v) async {
                          if (v == 'edit') {
                            final controller =
                                TextEditingController(text: c.text ?? '');
                            final res = await showDialog<String?>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Edit comment'),
                                content: TextField(
                                    controller: controller, maxLines: 3),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(null),
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () => Navigator.of(ctx)
                                          .pop(controller.text.trim()),
                                      child: const Text('Save')),
                                ],
                              ),
                            );
                            if (res != null && res.isNotEmpty) {
                              await CommentService.updateComment(
                                  comment: c, text: res);
                              _loadComments();
                            }
                          } else if (v == 'delete') {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete comment'),
                                content: const Text(
                                    'Are you sure you want to delete this comment?'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: const Text('Delete')),
                                ],
                              ),
                            );
                            if (confirmed == true) {
                              await CommentService.deleteComment(c);
                              _loadComments();
                            }
                          }
                        },
                        itemBuilder: (ctx) => [
                          const PopupMenuItem(
                              value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(
                              value: 'delete', child: Text('Delete')),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                          hintText: 'Add a short update...'),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _isPosting ? null : _postComment,
                icon: const Icon(Icons.send),
                label: _isPosting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
