import 'package:hive/hive.dart';

part 'task_recurrence.g.dart';

@HiveType(typeId: 3)
class TaskRecurrence {
  @HiveField(0)
  final RecurrenceType type;

  @HiveField(1)
  final List<int>? weekdays;

  // 🔑 CONSTRUCTOR PÚBLICO (OBLIGATORIO PARA HIVE)
  TaskRecurrence({
    required this.type,
    this.weekdays,
  });

  // -------- FACTORIES (API BONITA) --------
  factory TaskRecurrence.daily() {
    return TaskRecurrence(type: RecurrenceType.daily);
  }

  factory TaskRecurrence.weekly(List<int> days) {
    return TaskRecurrence(
      type: RecurrenceType.weekly,
      weekdays: days,
    );
  }

  factory TaskRecurrence.once() {
    return TaskRecurrence(type: RecurrenceType.once);
  }

  // -------- LÓGICA --------
  bool appliesTo(DateTime date) {
    switch (type) {
      case RecurrenceType.daily:
        return true;
      case RecurrenceType.weekly:
        return weekdays?.contains(date.weekday) ?? false;
      case RecurrenceType.once:
        return true;
    }
  }
}

@HiveType(typeId: 5)
enum RecurrenceType {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  once,
}
