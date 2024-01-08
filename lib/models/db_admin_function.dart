
import 'package:hive/hive.dart';

part 'db_admin_function.g.dart';

@HiveType(typeId: 0)
class Admin {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  int id;


  Admin({
  required this.name,
  required this.email,
  required this.id,
});
}