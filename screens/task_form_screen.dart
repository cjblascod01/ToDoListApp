import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../models/aptitude.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task; // si es null, estamos creando

  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _primaryAptitude;
  String? _secondaryAptitude;

  late Box<Task> taskBox;
  late Box<Aptitude> aptitudeBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasksBox');
    aptitudeBox = Hive.box<Aptitude>('aptitudesBox');

    if (widget.task != null) {
      _title = widget.task!.title;
      _primaryAptitude = widget.task!.primaryAptitudeId;
      _secondaryAptitude = widget.task!.secondaryAptitudeId;
    } else {
      _title = '';
    }
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    if (_primaryAptitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes elegir una aptitud principal')),
      );
      return;
    }

    if (widget.task != null) {
      // EDITAR
      widget.task!
        ..title = _title
        ..primaryAptitudeId = _primaryAptitude!
        ..secondaryAptitudeId = _secondaryAptitude
        ..save();
    } else {
      // CREAR
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      taskBox.put(
        id,
        Task(
          id: id,
          title: _title,
          primaryAptitudeId: _primaryAptitude!,
          secondaryAptitudeId: _secondaryAptitude,
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final aptitudes = aptitudeBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.task != null ? 'Editar Tarea' : 'Nueva Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Nombre de la tarea'),
                validator: (value) => value == null || value.isEmpty ? 'Obligatorio' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _primaryAptitude,
                decoration: const InputDecoration(labelText: 'Aptitud principal'),
                items: aptitudes
                    .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                    .toList(),
                onChanged: (value) => setState(() => _primaryAptitude = value),
                validator: (value) => value == null ? 'Debes elegir una aptitud' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _secondaryAptitude,
                decoration: const InputDecoration(labelText: 'Aptitud secundaria (opcional)'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Ninguna')),
                  ...aptitudes.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))),
                ],
                onChanged: (value) => setState(() => _secondaryAptitude = value),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Guardar tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
