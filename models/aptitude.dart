import 'package:hive/hive.dart';

part 'aptitude.g.dart';

@HiveType(typeId: 0)
class Aptitude extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> evolutions;

  @HiveField(3)
  int level;

  @HiveField(4)
  int xp;

  Aptitude({
    required this.id,
    required this.name,
    required this.evolutions,
    this.level = 1,
    this.xp = 0,
  });

  int get xpToNextLevel => level * 100;

  double get progress => xp / xpToNextLevel;

  String get currentPokemon {
    if (level >= 25 && evolutions.length >= 3) {
      return evolutions[2];
    } else if (level >= 10 && evolutions.length >= 2) {
      return evolutions[1];
    } else {
      return evolutions[0];
    }
  }

  // 🔥 MÉTODO CLAVE
  void addXp(int amount) {
    xp += amount;

    while (xp >= xpToNextLevel) {
      xp -= xpToNextLevel;
      level++;
    }

    save();
  }
}

