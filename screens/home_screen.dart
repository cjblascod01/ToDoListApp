import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/aptitude.dart';
import '../services/task_service.dart';
import '../screens/task_screen.dart';
import 'aptitude_card.dart';

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
  }

  // --------------------- Inicialización ---------------------
  void _initializeAptitudes() {
    final initialized = settingsBox.get('aptitudes_initialized', defaultValue: false);
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
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Gestionar tareas',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TasksScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          taskService.processEndOfDay();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Día procesado')),
          );
        },
        icon: const Icon(Icons.nightlight_round),
        label: const Text('Cerrar día'),
      ),
      body: ValueListenableBuilder(
        valueListenable: aptitudeBox.listenable(),
        builder: (context, Box<Aptitude> box, _) {
          final aptitudes = box.values.toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: aptitudes.length,
            itemBuilder: (context, index) {
              final aptitude = aptitudes[index];

              return AptitudeCard(
                aptitude: aptitude,
                onAddXp: () {}, // Ya no se usa manualmente
              );
            },
          );
        },
      ),
    );
  }
}
