// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/list_of_Categories/yoga.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
class Endurance extends StatefulWidget {
  final List<Addvideomodel> VideoList;
  final List<String> selectedCategories;
   const Endurance( {super.key,
  required this.VideoList,
  required this.selectedCategories
  });

  factory Endurance.create({
    required List<Addvideomodel> categoryVideoList,
    required List<String> selectedCategories,
  }){
    return Endurance(
      key: UniqueKey(),
     VideoList: const [],
       selectedCategories: selectedCategories
       );
  }
  

  @override
  State<Endurance> createState() => _EnduranceState();
}

class _EnduranceState extends State<Endurance> with SingleTickerProviderStateMixin {
  List<Addvideomodel>EnduranceVideos=[];

  late TabController _tabController;

  @override
  void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
  _fetchdata();
  }

  Future<void> _fetchdata() async{
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory.contains('Endurance'))
        .toList();

         setState(() {
      EnduranceVideos = filteredVideos;
    });

  }
  

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.grey,
          bottom: TabBar(
            controller: _tabController,
            tabs:const [
              Tab(text: 'Endurance',),
              Tab(text: 'Yoga',),
            ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                     shrinkWrap: true,
                    itemCount: EnduranceVideos.length,
                    itemBuilder: (context,index){
                       final video = EnduranceVideos[index];
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
            YogaScreen(videoList: widget.VideoList,
             selectedCategories: widget.selectedCategories,
             )
          ]),
      ),
    );
  }
}