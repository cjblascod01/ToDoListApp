import 'package:hive/hive.dart';
import '../models/task.dart';
import 'aptitude_service.dart';

class TaskService {
  final Box<Task> taskBox = Hive.box<Task>('tasksBox');
  final Box settingsBox = Hive.box('settings');

  static const int primaryXp = 100;
  static const int secondaryXp = 20;

  final AptitudeService _aptitudeService = AptitudeService();

  // 🔥 AUTOMÁTICO
  void checkAndProcessNewDay() {
    final lastDateString = settingsBox.get('last_day_closed');
    final now = DateTime.now();

    if (lastDateString == null) {
      _closeDay(now);
      return;
    }

    final lastDate = DateTime.parse(lastDateString);

    if (lastDate.year != now.year ||
        lastDate.month != now.month ||
        lastDate.day != now.day) {
      _closeDay(now);
    }
  }

  // 🧪 MANUAL
  void forceCloseDay() {
    _closeDay(DateTime.now());
  }

  // 🧠 LÓGICA CENTRAL
  void _closeDay(DateTime now) {
    for (final task in taskBox.values) {
      if (task.completedToday) {
        // 🔥 RACHA POSITIVA
        task.positiveStreak += 1;
        task.negativeStreak = 0;

        final multiplier = _positiveMultiplier(task.positiveStreak);

        _aptitudeService.addXp(
          task.primaryAptitudeId,
          (primaryXp * multiplier).round(),
        );

        if (task.secondaryAptitudeId != null) {
          _aptitudeService.addXp(
            task.secondaryAptitudeId!,
            (secondaryXp * multiplier).round(),
          );
        }
      } else {
        // ❄️ RACHA NEGATIVA
        task.negativeStreak += 1;
        task.positiveStreak = 0;

        final multiplier = _negativeMultiplier(task.negativeStreak);

        _aptitudeService.addXp(
          task.primaryAptitudeId,
          -(primaryXp ~/ 2 * multiplier).round(),
        );

        if (task.secondaryAptitudeId != null) {
          _aptitudeService.addXp(
            task.secondaryAptitudeId!,
            -(secondaryXp ~/ 2 * multiplier).round(),
          );
        }
      }

      task.completedToday = false;
      task.save();
    }

    settingsBox.put('last_day_closed', now.toIso8601String());
  }

  // 🔥 BONUS POR RACHA
  double _positiveMultiplier(int streak) {
    final effectiveStreak = streak - 1; // 👈 clave
    if (effectiveStreak <= 0) return 1.0;

    final value = 1 + effectiveStreak * 0.1;
    return value > 2.0 ? 2.0 : value;
  }

  // ❄️ CASTIGO POR RACHA
  double _negativeMultiplier(int streak) {
    final effectiveStreak = streak - 1;
    if (effectiveStreak <= 0) return 1.0;

    final value = 1 + effectiveStreak * 0.1;
    return value > 2.0 ? 2.0 : value;
  }
}
