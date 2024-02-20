// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationItemsAdapter extends TypeAdapter<NotificationItems> {
  @override
  final int typeId = 5;

  @override
  NotificationItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationItems(
      notifications: fields[0] as String?,
      notificationbody: fields[1] as String?,
      notificationpayload: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationItems obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.notifications)
      ..writeByte(1)
      ..write(obj.notificationbody)
      ..writeByte(2)
      ..write(obj.notificationpayload);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
