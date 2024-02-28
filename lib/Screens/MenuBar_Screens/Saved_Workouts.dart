// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';

class SavedWorkouts extends StatefulWidget {
  final List<Addvideomodel>? bookmarkedVideos;

  const SavedWorkouts({super.key, this.bookmarkedVideos});

  @override
  State<SavedWorkouts> createState() => _SavedWorkoutsState();
}

class _SavedWorkoutsState extends State<SavedWorkouts> {
  late ValueNotifier<List<Addvideomodel>> addvideoListNotifier;
  List _bookmarkedvideos = [];
  late Box<SavedWorkout> savedworkoutbox;


  @override
  void initState() {
    super.initState();
    _fetchSaved();
  }

Future<void> _fetchSaved() async {
  await Hive.openBox<SavedWorkout>('saved_workouts').then((box) {
    setState(() {
      savedworkoutbox = box;
      _bookmarkedvideos = savedworkoutbox.values.toList();
      _bookmarkedvideos.removeWhere((video) =>
      _bookmarkedvideos.any((v) => v.index == video.index) &&
      _bookmarkedvideos.indexOf(video) != _bookmarkedvideos.lastIndexOf(video));
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Saved Workouts'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          if (_bookmarkedvideos.isEmpty)
             const Padding(
               padding: EdgeInsets.only(top: 380),
               child: Center(
                child: Text('No videos Available')),
             )
          else
            ListView.builder(
              itemCount: _bookmarkedvideos.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                final video = _bookmarkedvideos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: SizedBox(
                      height: 280,
                      width: 100,
                      child: Image(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          video.imageBytes
                          ),
                        ),
                    ),
                    title: Text(video.title),
                    subtitle: Text(video.time),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => VideoScreenOne(
                        addvideomodel: Addvideomodel(
                          discription:video.discription,
                           title:video.title,
                            videoUrl:video.videoUrl,
                            imageBytes:video.imageBytes,
                             time: video.time,
                              selectedCategory: video.selectedCategory,
                               index: index
                               ),
                              ),
                            ),
                          );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
