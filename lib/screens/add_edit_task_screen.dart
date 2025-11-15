import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/app_background.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _discussionController;
  bool _isLoading = false;
  bool _isEditMode = false;
  String _status = 'New';
  DateTime? _startDate;
  DateTime? _endDate;
  String? _dateError;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.task != null;
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _discussionController = TextEditingController(text: widget.task?.discussion ?? '');
    _status = widget.task?.status ?? 'New';
    _startDate = widget.task?.startDate;
    _endDate = widget.task?.endDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _discussionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate date range
    if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
      setState(() {
        _dateError = 'End date must be the same or after start date';
      });
      return;
    } else {
      setState(() {
        _dateError = null;
      });
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      final response = _isEditMode
          ? await TaskService.updateTask(
              task: widget.task!,
              title: title,
              description: description,
              status: _status,
              startDate: _startDate,
              endDate: _endDate,
              discussion: _discussionController.text.trim(),
            )
          : await TaskService.createTask(
              title: title,
              description: description,
              status: _status,
              startDate: _startDate,
              endDate: _endDate,
              discussion: _discussionController.text.trim(),
            );

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _isEditMode
                    ? 'Task updated successfully'
                    : 'Task created successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.error?.message ?? 'Failed to save task'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Compose the form content separately to avoid deep nesting and ensure parentheses balance.
    // Use a ConstrainedBox + IntrinsicHeight so the form expands to at least the
    // viewport height. This ensures fields remain visible and the SingleChildScrollView
    // can scroll content above the keyboard instead of letting fields get hidden.
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
        ),
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Common label style to improve visibility
                Builder(builder: (ctx) {
                  // This Builder is just to scope the labelStyle variable; it won't build anything itself.
                  return const SizedBox.shrink();
                }),
                // Icon
                Icon(
                  _isEditMode ? Icons.edit_note : Icons.add_task,
                  size: 60,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    hintText: 'Enter task title',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                  maxLength: 100,
                ),
                const SizedBox(height: 20),
                // Status Dropdown
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  items: const [
                    DropdownMenuItem(value: 'New', child: Text('New')),
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Closed', child: Text('Closed')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (v) => setState(() => _status = v ?? 'New'),
                ),
                const SizedBox(height: 20),
                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Task Description',
                    hintText: 'Enter task description',
                    prefixIcon: const Icon(Icons.description),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 5,
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Start & End Dates
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => _startDate = picked);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          _startDate == null ? 'Start Date' : 'Start: ${_startDate!.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => _endDate = picked);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          _endDate == null ? 'End Date' : 'End: ${_endDate!.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_dateError != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      _dateError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                ] else
                  const SizedBox(height: 8),

                // Discussion / Short notes
                TextFormField(
                  controller: _discussionController,
                  decoration: InputDecoration(
                    labelText: 'Discussion / Notes',
                    hintText: 'Short update or discussion note',
                    prefixIcon: const Icon(Icons.chat_bubble_outline),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                  maxLength: 500,
                ),
                const SizedBox(height: 24),
                
                // Save Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _isEditMode ? 'Update Task' : 'Create Task',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 12),
                
                // Cancel Button
                OutlinedButton(
                  onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Task' : 'Add Task'),
        centerTitle: true,
      ),
      body: AppBackground(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: content,
        ),
      ),
    );
  }
}
