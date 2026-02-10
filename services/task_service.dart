import 'package:hive/hive.dart';
import '../models/task.dart';
import 'aptitude_service.dart';

class TaskService {
  static const int primaryXp = 50;
  static const int secondaryXp = 10;

  final Box<Task> _taskBox = Hive.box<Task>('tasksBox');
  final AptitudeService _aptitudeService = AptitudeService();

  void processEndOfDay() {
    for (final task in _taskBox.values) {
      if (task.completedToday) {
        // ---- RECOMPENSA ----
        _aptitudeService.addXp(task.primaryAptitudeId, primaryXp);

        if (task.secondaryAptitudeId != null) {
          _aptitudeService.addXp(
            task.secondaryAptitudeId!,
            secondaryXp,
          );
        }
      } else {
        // ---- PENALIZACIÓN ----
        _aptitudeService.addXp(task.primaryAptitudeId, -(primaryXp ~/ 2));

        if (task.secondaryAptitudeId != null) {
          _aptitudeService.addXp(
            task.secondaryAptitudeId!,
            -(secondaryXp ~/ 2),
          );
        }
      }

      // ---- RESET DIARIO ----
      task.completedToday = false;
      task.save();
    }
  }
}
