// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_admin_function.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminAdapter extends TypeAdapter<Admin> {
  @override
  final int typeId = 0;

  @override
  Admin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Admin(
      name: fields[0] as String,
      email: fields[1] as String,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Admin obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
