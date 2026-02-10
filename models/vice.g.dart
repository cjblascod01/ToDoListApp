// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViceAdapter extends TypeAdapter<Vice> {
  @override
  final int typeId = 4;

  @override
  Vice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vice(
      id: fields[0] as String,
      title: fields[1] as String,
      primaryAptitudeId: fields[2] as String,
      secondaryAptitudeId: fields[3] as String?,
      completedToday: fields[4] as bool,
      positiveStreak: fields[5] as int,
      negativeStreak: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Vice obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.primaryAptitudeId)
      ..writeByte(3)
      ..write(obj.secondaryAptitudeId)
      ..writeByte(4)
      ..write(obj.completedToday)
      ..writeByte(5)
      ..write(obj.positiveStreak)
      ..writeByte(6)
      ..write(obj.negativeStreak);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
