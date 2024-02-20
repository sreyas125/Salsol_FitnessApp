
import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class  Test{
  
@HiveField(0)
String? notifications;

@HiveField(1)
String? notificationbody;

@HiveField(2)
String? notificationpayload;

  Test({
  required this.notifications,
  required this.notificationbody,
  required this.notificationpayload,
  });
}