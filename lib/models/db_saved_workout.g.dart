// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_saved_workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedWorkoutAdapter extends TypeAdapter<SavedWorkout> {
  @override
  final int typeId = 4;

  @override
  SavedWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedWorkout(
      discription: fields[1] as String,
      imageBytes: fields[3] as Uint8List,
      index: fields[6] as int?,
      selectedCategory: fields[5] as String,
      time: fields[4] as String,
      title: fields[2] as String,
      videoUrl: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedWorkout obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.videoUrl)
      ..writeByte(1)
      ..write(obj.discription)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.imageBytes)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.selectedCategory)
      ..writeByte(6)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
