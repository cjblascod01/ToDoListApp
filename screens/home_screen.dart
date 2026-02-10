import 'package:evolve_me/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/aptitude.dart';
import '../screens/task_screen.dart';
import '../widgets/aptitude_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Aptitude> aptitudeBox;
  late Box settingsBox;
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();

    aptitudeBox = Hive.box<Aptitude>('aptitudesBox');
    settingsBox = Hive.box('settings');

    _initializeAptitudes();

    // 🔥 CIERRE AUTOMÁTICO
    taskService.checkAndProcessNewDay();
  }

  // --------------------- Inicialización ---------------------
  void _initializeAptitudes() {
    final initialized =
        settingsBox.get('aptitudes_initialized', defaultValue: false);
    if (initialized) return;

    aptitudeBox.putAll({
      'strength': Aptitude(
        id: 'strength',
        name: 'Fuerza',
        evolutions: ['Machop', 'Machoke', 'Machamp'],
      ),
      'intelligence': Aptitude(
        id: 'intelligence',
        name: 'Inteligencia',
        evolutions: ['Abra', 'Kadabra', 'Alakazam'],
      ),
      'discipline': Aptitude(
        id: 'discipline',
        name: 'Disciplina',
        evolutions: ['Riolu', 'Lucario'],
      ),
    });

    settingsBox.put('aptitudes_initialized', true);
  }

  // --------------------- UI ---------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evolve Me'),
        actions: [
          // 🧪 BOTÓN TEST
          IconButton(
            icon: const Icon(Icons.skip_next),
            tooltip: 'Cerrar día (TEST)',
            onPressed: () {
              taskService.forceCloseDay();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Día cerrado manualmente')),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Añadir tarea'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TasksScreen()),
          );
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: aptitudeBox.listenable(),
        builder: (context, Box<Aptitude> box, _) {
          final aptitudes = box.values.toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: aptitudes.length,
            itemBuilder: (context, index) {
              return AptitudeCard(
                aptitude: aptitudes[index],
                onAddXp: () {},
              );
            },
          );
        },
      ),
    );
  }
}
