import 'package:hive/hive.dart';

part 'aptitude.g.dart';

@HiveType(typeId: 0)
class Aptitude extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  int level;

  @HiveField(3)
  int xp;

  @HiveField(4)
  final List<String> evolutions;

  Aptitude({
    required this.id,
    required this.name,
    this.level = 1,
    this.xp = 0,
    required this.evolutions,
  });

  // ---------- DERIVADOS ----------
  int get xpToNextLevel => 100 + (level - 1) * 50;

  double get progress => (xp / xpToNextLevel).clamp(0.0, 1.0);

  String get currentPokemon {
    if (level >= 25 && evolutions.length >= 3) {
      return evolutions[2];
    } else if (level >= 10 && evolutions.length >= 2) {
      return evolutions[1];
    } else {
      return evolutions[0];
    }
  }

}
