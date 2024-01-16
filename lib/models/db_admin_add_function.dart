
import 'dart:typed_data';

import 'package:hive/hive.dart';
   part 'db_admin_add_function.g.dart';

   @HiveType(typeId: 1)
  class Addvideomodel{
 
   @HiveField(0)
     String title;

   @HiveField(1)
     String videoUrl;

   @HiveField(2)
     String discription;

   @HiveField(3)
   late Uint8List imageBytes;

   @HiveField(4)
    String time;

   @HiveField(5)
    String? selectedCategory;

   @HiveField(6)
   late int? index;

   Addvideomodel({
    required this.discription,
    required this.title,
    required this.videoUrl,
    required this.imageBytes,
    required this.time,
    required this.selectedCategory,
    required this.index,
   });
  }