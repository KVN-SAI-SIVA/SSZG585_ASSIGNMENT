import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Checkbox
                  Transform.scale(
                    scale: 1.12,
                    child: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => onToggle(),
                      shape: const CircleBorder(),
                    ),
                  ),
                  
                  // Title and Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title ?? 'Untitled',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted
                                ? Colors.grey
                                : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(task.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Status pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(task.status ?? (task.isCompleted ? 'Closed' : 'New')).withAlpha((0.12 * 255).round()),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                task.status ?? (task.isCompleted ? 'Closed' : 'New'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _statusColor(task.status ?? (task.isCompleted ? 'Closed' : 'New')),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Date range
                            if (task.startDate != null || task.endDate != null)
                              Text(
                                '${task.startDate != null ? DateFormat('yyyy-MM-dd').format(task.startDate!) : '-'} → ${task.endDate != null ? DateFormat('yyyy-MM-dd').format(task.endDate!) : '-'}',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: onDelete,
                    tooltip: 'Delete task',
                  ),
                ],
              ),
              
              // Description
                if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 56.0),
                  child: Text(
                    task.description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: task.isCompleted ? Colors.grey : Colors.grey[700],
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
                // Discussion snippet
                if (task.discussion != null && task.discussion!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 56.0),
                    child: Row(
                      children: [
                        Icon(Icons.forum_outlined, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            task.discussion!,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color(0xFF0B79FF); // AppColors.statusNew
      case 'active':
        return const Color(0xFFD97706); // AppColors.statusActive
      case 'closed':
        return const Color(0xFF0F9D58); // AppColors.statusClosed
      default:
        return Colors.grey;
    }
  }
}
