// ignore_for_file: file_names
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/db/functions/db_add_function.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';
import 'package:salsol_fitness/widgets/workout_widget_refactor.dart';

class ForYou extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ForYou({Key? key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  List<Addvideomodel> videoList = [];
  List<Addvideomodel> greatForHomeVideos = [];
  List<Addvideomodel>limitedNewWorkouts = [];
  Uint8List? adminImageBytes;
  late ValueNotifier<List<Addvideomodel>> addvideoListNotifier;

  int maxVideosToshow = 6;
  int newVideosOffset = 0;

  @override
  void initState() {
    super.initState();
    addvideoListNotifier = ValueNotifier<List<Addvideomodel>>([]);
    fetchVideos();
    fetchGreatForHomeVideos();
    __getImageFromAdmin();
    _fetchLatestVideos();
  }

  Future<void> __getImageFromAdmin() async {
    final imageBytes = await Hive.box('images').get('image') as Uint8List?;
    if (imageBytes != null) {
      setState(() {
        adminImageBytes = imageBytes;
      });
    }
  }

  Future<void> fetchVideos() async {
    final box = await Hive.openBox<Addvideomodel>('videos');
    setState(() {
      videoList = box.values.toList();
    });
  }

  Future<void> fetchGreatForHomeVideos() async {
    final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory.contains('Great From Home'))
        .toList();

    setState(() {
      greatForHomeVideos = filteredVideos;
    });
  }

  Future<void> _fetchLatestVideos() async{
    final box = Hive.box<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();
    allVideos.sort((a, b ) => b.index!.compareTo(a.index!));
    setState(() {
    limitedNewWorkouts = allVideos.take(maxVideosToshow).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: limitedNewWorkouts.length,
              itemBuilder: (BuildContext context, int index) {
                final video = limitedNewWorkouts[index];
                 SavedWorkout workout = SavedWorkout(
                      discription: video.title,
                       imageBytes: video.imageBytes,
                        index: video.index,
                         selectedCategory:video.selectedCategory,
                          time: video.time, 
                          title:video.title,
                           videoUrl:video.videoUrl,
                           );
                // print('this is the limited new workouts ${limitedNewWorkouts.length}');
                // print('id: ${video.index}');
                return WorkOutImage(
                  workimage: video.imageBytes,
                  worktitle: video.title,
                  times: video.time,
                  selectedCategory: video.selectedCategory,
                  index: video.index!,
                  videoUrl: video.videoUrl,
                  nav: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => VideoScreenOne(
                          addvideomodel: video,
                        ),
                      ),
                    );
                  },
                  onBookmarChanged: (bool isBookmarked) {
                    if (isBookmarked) {
                      print('isBookmarked');
                          print(workout.index);
                           saveWorkouts(workout);
                           print('blahh');
                       }else{
                        print('inside the delete');
                           addVideoListNotifier.value = [...addVideoListNotifier.value]..remove(video);
                            deleteFromsavedWorkouts(workout.index!);
                       }
                  },
                  addVideoListNotifier: addvideoListNotifier,
                );
              },
            ),
          ),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Great For Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: greatForHomeVideos.length,
              itemBuilder: (BuildContext context, int index) {
                final video = greatForHomeVideos[index];
                 SavedWorkout workout = SavedWorkout(
                      discription: video.title,
                       imageBytes: video.imageBytes,
                        index: video.index,
                         selectedCategory:video.selectedCategory,
                          time: video.time, 
                          title:video.title,
                           videoUrl:video.videoUrl,
                           );
                // print('this is the limited new workouts ${limitedNewWorkouts.length}');
                // print('id: ${video.index}');
                return WorkOutImage(
                  workimage: video.imageBytes,
                   worktitle: video.title,
                    times: video.time,
                     index: index,
                     videoUrl: video.videoUrl,
                     selectedCategory: video.selectedCategory,
                     nav: (){
                        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => VideoScreenOne(
                          addvideomodel: video,
                        ),
                      ));
                     }, onBookmarChanged: (bool isBookmarked) { 
                        if(isBookmarked){
                            saveWorkouts(workout);
                        }else{
                          addvideoListNotifier.value = [...addvideoListNotifier.value]..remove(video);
                          deleteFromsavedWorkouts(workout.index!);

                        }
                      }, addVideoListNotifier: addvideoListNotifier, 
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
