import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class YogaScreen extends StatefulWidget {
  final List<String> selectedCategories;
  final List<Addvideomodel> videoList;

  const YogaScreen({
    super.key,
  required this.videoList,
  required this.selectedCategories
  });

  factory YogaScreen.create({
    required List<Addvideomodel>categoryVideoList,
    required List<String> selectedCategories,
  }){
    return YogaScreen(
      key: UniqueKey(),
      videoList: [],
      selectedCategories: selectedCategories,
      );
  }

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
    List<Addvideomodel>YogaVideos=[];

  Future<void> _fetchyogadata() async{
    print('inside the box');
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory.contains('Yoga'))
        .toList();

         setState(() {
     YogaVideos = filteredVideos;
    });

  }
  @override
  void initState() {
    super.initState();
    _fetchyogadata();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                     shrinkWrap: true,
                    itemCount: YogaVideos.length,
                    itemBuilder: (context,index){
                       final video = YogaVideos[index];
                      return ListTile(
                        leading: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(video.imageBytes
                              ),
                            ),
                          ),
                        ),
                        title: Text(video.title),
                        subtitle: Text(video.time),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                              discription:video.discription,
                               title:video.title,
                                videoUrl:video.videoUrl,
                                 imageBytes:video.imageBytes,
                                  time:video.time,
                                   selectedCategory: video.selectedCategory,
                                    index: index,
                                    )
                                  ),
                                  )
                                );
                             },
                         );
                    }),
                )
              ],
            ),
    );
  }
}