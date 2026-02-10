// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aptitude.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AptitudeAdapter extends TypeAdapter<Aptitude> {
  @override
  final int typeId = 0;

  @override
  Aptitude read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Aptitude(
      id: fields[0] as String,
      name: fields[1] as String,
      level: fields[2] as int,
      xp: fields[3] as int,
      evolutions: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Aptitude obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.xp)
      ..writeByte(4)
      ..write(obj.evolutions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AptitudeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
