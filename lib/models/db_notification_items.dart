import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class NotificationItems {
  @HiveField(0)
  String? notification;

  @HiveField(1)
  String? notificationbody;

  @HiveField(2)
  String? notificationpayload;

  NotificationItems({
  required this.notification,
  required this.notificationbody,
  this.notificationpayload,
  });
}