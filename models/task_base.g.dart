// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskBaseAdapter extends TypeAdapter<TaskBase> {
  @override
  final int typeId = 2;

  @override
  TaskBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskBase(
      id: fields[0] as String,
      title: fields[1] as String,
      primaryAptitudeId: fields[2] as String,
      secondaryAptitudeId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskBase obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.primaryAptitudeId)
      ..writeByte(3)
      ..write(obj.secondaryAptitudeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
