// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_Guidance_add_function.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuidanceAdapter extends TypeAdapter<Guidance> {
  @override
  final int typeId = 3;

  @override
  Guidance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Guidance(
      title: fields[0] as String,
      paragraph: fields[1] as String,
      Category: fields[2] as String,
      imageBytes: fields[3] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, Guidance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.paragraph)
      ..writeByte(2)
      ..write(obj.Category)
      ..writeByte(3)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuidanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
