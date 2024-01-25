import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
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
    final List<Addvideomodel> filteredVideos = widget.bookmarkedVideos ?? [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Saved Workouts'),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          if(widget.bookmarkedVideos == null || widget.bookmarkedVideos!.isEmpty)
             Center(
              child: Text('No videos Available'),
          )
          else
            Expanded(
              child: ListView.builder(
              itemCount: widget.bookmarkedVideos!.length,
              itemBuilder: (context,index){
                final video = widget.bookmarkedVideos![index];
                return ListTile(
                  title: Text(video.title),
                  subtitle: Text(video.time),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => VideoScreenOne(addvideomodel: video),));
                  },
                   
                );
              }),
            )
        ],
      ),
    );
  }
}