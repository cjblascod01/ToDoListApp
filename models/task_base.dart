import 'package:hive/hive.dart';

part 'task_base.g.dart';

@HiveType(typeId: 2)
class TaskBase extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String primaryAptitudeId;
  @HiveField(3)
  String? secondaryAptitudeId;
  bool completedToday;
  int positiveStreak;
  int negativeStreak;

  TaskBase({
    required this.id,
    required this.title,
    required this.primaryAptitudeId,
    this.secondaryAptitudeId,
    this.completedToday = false,
    this.positiveStreak = 0,
    this.negativeStreak = 0,
  });
}