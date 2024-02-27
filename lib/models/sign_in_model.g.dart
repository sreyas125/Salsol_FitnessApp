// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

// ignore: camel_case_types
class fitnessModelAdapter extends TypeAdapter<fitnessModel> {
  @override
  final int typeId = 2;

  @override
  fitnessModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return fitnessModel(
      email: fields[1] as String?,
      password: fields[2] as String,
      id: fields[0] as String?,
      name: fields[3] as String?,
      surName: fields[4] as String?,
      dateOfBirth: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, fitnessModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.surName)
      ..writeByte(5)
      ..write(obj.dateOfBirth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is fitnessModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
