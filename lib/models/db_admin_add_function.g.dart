// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_admin_add_function.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddvideomodelAdapter extends TypeAdapter<Addvideomodel> {
  @override
  final int typeId = 1;

  @override
  Addvideomodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addvideomodel(
      discription: fields[2] as String,
      title: fields[0] as String,
      videoUrl: fields[1] as String,
      imageBytes: fields[3] as Uint8List,
      time: fields[4] as String,
      selectedCategory: fields[5] as String,
      index: fields[6] as int?,
      id: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Addvideomodel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.videoUrl)
      ..writeByte(2)
      ..write(obj.discription)
      ..writeByte(3)
      ..write(obj.imageBytes)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.selectedCategory)
      ..writeByte(6)
      ..write(obj.index)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddvideomodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
