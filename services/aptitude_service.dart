import 'package:hive/hive.dart';
import '../models/aptitude.dart';

class AptitudeService {
  final Box<Aptitude> _aptitudeBox = Hive.box<Aptitude>('aptitudesBox');

  static const int baseXpPerLevel = 100;

  void addXp(String aptitudeId, int amount) {
    final aptitude = _aptitudeBox.get(aptitudeId);
    if (aptitude == null) return;

    if (amount >= 0) {
      _addPositiveXp(aptitude, amount);
    } else {
      _removeXp(aptitude, amount.abs());
    }

    aptitude.save();
  }

  // -------- XP POSITIVA --------
  void _addPositiveXp(Aptitude aptitude, int amount) {
    aptitude.xp += amount;

    while (aptitude.xp >= aptitude.xpToNextLevel) {
      aptitude.xp -= aptitude.xpToNextLevel;
      aptitude.level++;
    }
  }

  // -------- XP NEGATIVA --------
  void _removeXp(Aptitude aptitude, int amount) {
    if (aptitude.level == 1 && aptitude.xp == 0) return;

    aptitude.xp -= amount;

    while (aptitude.xp < 0 && aptitude.level > 1) {
      aptitude.level--;

      final xpForPreviousLevel = aptitude.xpToNextLevel;
      aptitude.xp += xpForPreviousLevel;
    }

    // Seguridad final
    if (aptitude.level == 1 && aptitude.xp < 0) {
      aptitude.xp = 0;
    }
  }
}
