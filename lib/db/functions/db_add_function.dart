

// ignore_for_file: non_constant_identifier_names

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
  print("saved to box");
  final savedworkoutbox = await Hive.openBox<SavedWorkout>('saved_workouts');
  final savedWorkouts = SavedWorkout(
    discription: savedWorkout.discription,
     imageBytes: savedWorkout.imageBytes,
      index: savedWorkout.index,
       selectedCategory: savedWorkout.selectedCategory,
        time: savedWorkout.time,
         title: savedWorkout.title,
          videoUrl: savedWorkout.videoUrl,
          id: savedWorkout.id
          );
          bool alreadyExists = savedworkoutbox.values.any((favVideo) => favVideo.id == savedWorkout.id);
          if (!alreadyExists) {
  await savedworkoutbox.add(savedWorkouts);
}
           savedworkoutbox.close();

}

void deleteFromsavedWorkouts(int id) async {
  final SavedWorkoutBox = await Hive.openBox<SavedWorkout>('saved_workouts');

  // Find the workout with the specified ID
  for (int i = 0; i < SavedWorkoutBox.length; i++) {
    final workout = SavedWorkoutBox.getAt(i);
    if (workout?.index == id) {
      await SavedWorkoutBox.deleteAt(i);
      print('Workout with ID $id removed');
      return; // Exit the function once the workout is found and deleted
    }
  }

  // If the workout with the specified ID is not found
  print('Workout with ID $id not found');
}
