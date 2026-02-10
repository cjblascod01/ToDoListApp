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
      evolutions: (fields[2] as List).cast<String>(),
      level: fields[3] as int,
      xp: fields[4] as int,
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
      ..write(obj.evolutions)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.xp);
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
