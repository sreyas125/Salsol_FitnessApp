import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class SavedWorkouts extends StatefulWidget {
  final List<Addvideomodel>? bookmarkedVideos;
  const SavedWorkouts({super.key,this.bookmarkedVideos});

  @override
  State<SavedWorkouts> createState() => _SavedWorkoutsState();
}

class _SavedWorkoutsState extends State<SavedWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Saved Workouts'),
        leading: BackButton(),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}