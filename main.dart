import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'models/aptitude.dart';
import 'models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AptitudeAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Aptitude>('aptitudesBox');
  await Hive.openBox('settings');
  await Hive.openBox<Task>('tasksBox');

  runApp(const UpgradeMeApp());
}



class UpgradeMeApp extends StatelessWidget {
  const UpgradeMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evolve Me',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
