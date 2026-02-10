import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  /// Aptitud principal (50 XP)
  @HiveField(2)
  String primaryAptitudeId;

  /// Aptitud secundaria (10 XP)
  @HiveField(3)
  String? secondaryAptitudeId;

  /// Marcada durante el día
  @HiveField(4)
  bool completedToday;

  @HiveField(5) 
  int positiveStreak; 

  @HiveField(6) 
  int negativeStreak;

  Task({ 
    required this.id, 
    required this.title, 
    required this.primaryAptitudeId, 
    this.secondaryAptitudeId, 
    this.completedToday = false, 
    this.positiveStreak = 0, 
    this.negativeStreak = 0, });
}
