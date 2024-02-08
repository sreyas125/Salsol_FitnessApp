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
  List<Addvideomodel> bookmarkedVideos = [];
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
        .where((video) => video.selectedCategory == 'Great From Home')
        .toList();

    setState(() {
      greatForHomeVideos = filteredVideos;
    });
  }

  List<Addvideomodel> getLimitedNewWorkouts(){
    final List<Addvideomodel> limitedList = [];
    final int endIndex = newVideosOffset + maxVideosToshow;

    for(int i=newVideosOffset;i<endIndex && i<videoList.length;i++){
      limitedList.add(videoList[i]);
    }
    return limitedList;
  }

  @override
  Widget build(BuildContext context) {
    List<Addvideomodel> limitedNewWorkouts = getLimitedNewWorkouts();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: limitedNewWorkouts.length,
              itemBuilder: (BuildContext context, int index) {
                final video = videoList[index];
                return WorkOutImage(
                  workimage: video.imageBytes,
                  worktitle: video.title,
                  times: video.time,
                  selectedCategory: '',
                  index: video.index?? -1,
                  videoUrl: video.videoUrl,
                  onBookmarChanged: (bool isBookmarked) {
                    if (isBookmarked) {
                      print('isBookmarked');
                     SavedWorkout workout = SavedWorkout(
                      discription: video.title,
                       imageBytes: video.imageBytes,
                        index: index,
                         selectedCategory:video.selectedCategory,
                          time: video.time, 
                          title:video.title,
                           videoUrl:video.videoUrl
                           );
                          
                           saveWorkouts(workout);
                           print('blahh');
                       }else{
                           addVideoListNotifier.value = [...addVideoListNotifier.value]..remove(video);
                            deleteFromsavedWorkouts(video.index ?? -1);
                       }

                  },
                  addVideoListNotifier: addvideoListNotifier,
                  nav: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => VideoScreenOne(
                          addvideomodel: video,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
                          SavedWorkout workout = SavedWorkout(
                            discription: video.title,
                             imageBytes: video.imageBytes,
                              index: index,
                               selectedCategory: video.selectedCategory,
                                time: video.time,
                                 title: video.title,
                                  videoUrl: video.videoUrl
                                  );
                                  saveWorkouts(workout);
                        }else{
                          addvideoListNotifier.value = [...addvideoListNotifier.value]..remove(video);

                          deleteFromsavedWorkouts(video.index ?? -1);
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
