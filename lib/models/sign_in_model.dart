
// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';
part 'sign_in_model.g.dart';

@HiveType(typeId: 2)

class fitnessModel{

  @HiveField(0)
  String? id;
  
  @HiveField(1)
  String? email;

  @HiveField(2)
  String password;

  
  @HiveField(3)
  String? name;

  
  @HiveField(4)
  String? surName;


  @HiveField(5)
 String dateOfBirth;

 fitnessModel({
  required this.email,
  required this.password,
  this.id,
  required this.name,
  required this.surName,
  required this.dateOfBirth
  });
  
}
