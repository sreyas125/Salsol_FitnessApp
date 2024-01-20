// ignore_for_file: unnecessary_to_list_in_spreads, use_key_in_widget_constructors
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/MenuBar_Screens/Saved_Workouts.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/widgets/Great_For_Home.dart';
import 'package:salsol_fitness/widgets/workout_widget_refactor.dart';

class ForYou extends StatefulWidget {
  const ForYou({Key? key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  List<Addvideomodel> videoList = [];
  List<Addvideomodel> greatForHomeVideos = [];
  List<Addvideomodel> bookmarkedVideos = [];
  Uint8List? adminImageBytes;

  @override
  void initState() {
    super.initState();
    fetchVideos();
    fetchGreatForHomeVideos();
     __getImageFromAdmin();
  }

  Future<void>__getImageFromAdmin() async{
    final imageBytes = await Hive.box('images').get('image') as Uint8List?;
    if(imageBytes != null) {
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

  void handleBookmarkChange(bool isBookmarked, Addvideomodel video){
    setState(() {
      if(isBookmarked){
        bookmarkedVideos.add(video);
      }else{
        bookmarkedVideos.remove(video);
      }
    });
  }

   void navigateToSavedWorkouts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=>SavedWorkouts(
          bookmarkedVideos: bookmarkedVideos,)
         ),
      );
   }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
                scrollDirection:Axis.horizontal,
                itemCount: videoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final video = videoList[index];
                    return WorkOutImage(
                      workimage: video.imageBytes,
                      worktitle: video.title,
                      times: video.time,
                      nav: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => VideoScreenOne(
                              addvideomodel: video,
                              ),
                            )
                         );
                      },
                      onBookmarChanged: ((isBookmarked) => 
                      handleBookmarkChange(isBookmarked, video)),
                    );
                  }
                ),  
            ),
           const  Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Great For Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
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
              itemBuilder: (BuildContext context, int index){
               final video = greatForHomeVideos[index];
                return GreatFromHome(
                  workimage: video.imageBytes,
                   worktitle: video.title,
                    times: video.time,
                     nav: (){
                      Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                         builder: (context) => VideoScreenOne(
                         addvideomodel: video
                           ),
                         ),
                       );
                     });
                  }
               ),
            ),
        ],
      ),
    );
   }
}
