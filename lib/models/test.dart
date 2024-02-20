
import 'package:hive/hive.dart';
part 'test.g.dart';

@HiveType(typeId: 5)
class  NotificationItems{
  
@HiveField(0)
String? notifications;

@HiveField(1)
String? notificationbody;

@HiveField(2)
String? notificationpayload;

  NotificationItems({
  required this.notifications,
  required this.notificationbody,
  required this.notificationpayload,
  });
}