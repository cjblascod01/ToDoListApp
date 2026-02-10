import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(task.title),
      value: task.completedToday,
      onChanged: (value) {
        task.completedToday = value ?? false;
        task.save();
      },
    );
  }
}
