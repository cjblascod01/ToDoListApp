import 'package:evolve_me/screens/task_form_screen.dart'; 
import 'package:flutter/material.dart'; 
import 'package:hive_flutter/hive_flutter.dart'; 
import '../models/task.dart'; 
import '../models/aptitude.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBox = Hive.box<Task>('tasksBox');
    final aptitudeBox = Hive.box<Aptitude>('aptitudesBox');
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Crear tarea'),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const TaskFormScreen()));
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          final tasks = box.values.toList();
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No hay tareas todavía',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final primary =
                  aptitudeBox.get(task.primaryAptitudeId)?.name ?? '—';
              final secondary = task.secondaryAptitudeId != null
                  ? aptitudeBox.get(task.secondaryAptitudeId!)?.name
                  : null;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --------- TÍTULO + CHECK ---------
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: task.completedToday,
                            onChanged: (_) {
                              task.completedToday = !task.completedToday;
                              task.save();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ), // --------- APTITUDES ---------
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Chip(label: Text('🎯 $primary (+50 XP)')),
                          if (secondary != null)
                            Chip(label: Text('➕ $secondary (+10 XP)')),
                        ],
                      ),
                      const SizedBox(height: 8), // --------- STREAKS ---------
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => TaskFormScreen(task: task),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              task.delete();
                            },
                          ),
                          if (task.positiveStreak > 0)
                            _StreakBadge(
                              icon: '🔥',
                              text:
                                  '${task.positiveStreak} día${task.positiveStreak > 1 ? 's' : ''}',
                              color: Colors.green,
                            ),
                          if (task.negativeStreak > 0)
                            _StreakBadge(
                              icon: '❄️',
                              text:
                                  '${task.negativeStreak} fallo${task.negativeStreak > 1 ? 's' : ''}',
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
} // ------------------------------------------------------------ // 🔥 / ❄️ BADGE DE STREAK // ------------------------------------------------------------

class _StreakBadge extends StatelessWidget {
  final String icon;
  final String text;
  final Color color;
  const _StreakBadge({
    required this.icon,
    required this.text,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
