

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

ValueNotifier<List<Addvideomodel>> addVideoListNotifier = ValueNotifier([]);

Future<void> addvideo(Addvideomodel value)async{
 final addvideoDB = await Hive.openBox<Addvideomodel>('Addvideo_db');
  await addvideoDB.add(value);
}

Future<void>getAllvideos() async{
  final addvideoDB = await Hive.openBox<Addvideomodel>('Addvideo_db');
  addVideoListNotifier.value.clear();

  addVideoListNotifier.value.addAll(addvideoDB.values);
  List<Addvideomodel> allvideos = addvideoDB.values.cast<Addvideomodel>().toList();
}