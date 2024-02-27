import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Heightweight {

@HiveField(0)
double? height;

@HiveField(1)
String? weight;

}