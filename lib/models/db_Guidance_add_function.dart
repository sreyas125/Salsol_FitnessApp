// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'db_Guidance_add_function.g.dart';

@HiveType(typeId: 3)
class Guidance {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String paragraph;
 
  @HiveField(2)
  late String Category;

  @HiveField(3)
   Uint8List imageBytes;

  Guidance({
  required this.title,
  required this.paragraph,
  required this.Category,
  required this.imageBytes,
});
}