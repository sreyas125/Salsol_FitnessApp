import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';

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
        title:const Text('Saved Workouts'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          if(widget.bookmarkedVideos == null || widget.bookmarkedVideos!.isEmpty)
          const Center(
            child: Text('No videos Available'),
          )
          else
          Expanded(
            child: ListView.builder(
              itemBuilder: (context,index){
                final video = widget.bookmarkedVideos![index];
                return ListTile(
                  title: Text(video.title),
                  subtitle: Text(video.time),
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => VideoScreenOne(
                        addvideomodel:Addvideomodel(
                          discription: video.discription,
                           title: video.title,
                            videoUrl: video.videoUrl,
                             imageBytes: video.imageBytes,
                              time: video.time,
                               selectedCategory: video.selectedCategory,
                                index: index,
                                )),
                        ),
                      );
                  },
                );
              })
          ),
        ],
      ),
    );
  }
}