import 'package:hive/hive.dart';
import 'task_base.dart';

part 'vice.g.dart';

@HiveType(typeId: 4)
class Vice extends TaskBase{
  @HiveField(0)
  @override
  String id;

  @HiveField(1)
  @override
  String title;

  @HiveField(2)
  @override
  String primaryAptitudeId;

  @HiveField(3)
  @override
  String? secondaryAptitudeId;

  @HiveField(4)
  @override
  bool completedToday;

  @HiveField(5)
  @override
  int positiveStreak;

  @HiveField(6)
  @override
  int negativeStreak;

  Vice({
    required this.id,
    required this.title,
    required this.primaryAptitudeId,
    this.secondaryAptitudeId,
    this.completedToday = false,
    this.positiveStreak = 0,
    this.negativeStreak = 0,
  }) : super(
          id: id,
          title: title,
          primaryAptitudeId: primaryAptitudeId,
          secondaryAptitudeId: secondaryAptitudeId,
          completedToday: completedToday,
          positiveStreak: positiveStreak,
          negativeStreak: negativeStreak,
        );
}
