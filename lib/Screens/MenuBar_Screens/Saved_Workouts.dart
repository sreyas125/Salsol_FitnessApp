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
              shrinkWrap: true,
              padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemCount: _bookmarkedvideos.length,
                itemBuilder: (context, index) {
                  final video = _bookmarkedvideos[index];
                  return ListTile(
                    leading:Container(
                      width: 150,
                      height: 350,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(
                            video.imageBytes
                            ),
                          ),
                        ),
                      ),
                    title: Text(video.title),
                    subtitle: Text(video.time),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                              discription: video.discription,
                              title: video.title,
                              videoUrl: video.videoUrl,
                              imageBytes: video.imageBytes,
                              time: video.time,
                              selectedCategory: video.selectedCategory,
                              index: index,
                            ),
                          ),
                        ),
                     );
                  },
               );
             }
            ),
        ],
      ),
    );
  }
}
