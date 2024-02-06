
import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'db_saved_workout.g.dart';

@HiveType(typeId: 4)
class SavedWorkout {
  @HiveField(0)
  String videoUrl;

  @HiveField(1)
  String discription;

  @HiveField(2)
  String title;

  @HiveField(3)
  late Uint8List imageBytes;

  @HiveField(4)
  String time;  

  @HiveField(5)
  String selectedCategory;

  @HiveField(6)
   int? index;


  SavedWorkout({
    required this.discription,
    required this.imageBytes,
    required this.index,
    required this.selectedCategory,
    required this.time,
    required this.title,
    required this.videoUrl,
  });
}