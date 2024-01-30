

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';

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

Future<void> saveWorkouts(SavedWorkout savedWorkout) async{
  final savedworkoutbox = await Hive.openBox<SavedWorkout>('saved_workouts');
  final savedWorkouts = SavedWorkout(
    discription: savedWorkout.discription,
     imageBytes: savedWorkout.imageBytes,
      index: savedWorkout.index,
       selectedCategory: savedWorkout.selectedCategory,
        time: savedWorkout.time,
         title: savedWorkout.title,
          videoUrl: savedWorkout.videoUrl
          );
          await savedworkoutbox.add(savedWorkouts);
}

 void deleteFromsavedWorkouts(int index) async{
  final SavedWorkoutBox = await Hive.openBox<SavedWorkout>('saved_workouts');
  if(index >=0 && index < SavedWorkoutBox.length){
    await SavedWorkoutBox.deleteAt(index);
  }
 }