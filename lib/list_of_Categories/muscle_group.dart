// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
class MuscleGroupScreen extends StatefulWidget {
  final List<Addvideomodel> videoList;
  final List<String> selectedCategories;

  const MuscleGroupScreen({
    super.key,
    required this.videoList,
    required this.selectedCategories
    });

factory MuscleGroupScreen.create({
  required List<Addvideomodel>categoryvideoList,
  required List<String> selectedCategories,
}){
  return MuscleGroupScreen(
    key: UniqueKey(),
    videoList: const [],
     selectedCategories: selectedCategories
     );
}

  @override
  State<MuscleGroupScreen> createState() => MuscleGroupScreenState();
}

class MuscleGroupScreenState extends State<MuscleGroupScreen>with SingleTickerProviderStateMixin {
   late TabController _tabController;
   List<Addvideomodel>ArmsShoulderVideos =[];
   List<Addvideomodel>AbsCorevideos=[];

   @override
  void initState() {
    super.initState();
    _fetchArmsShoulder();
    _fetchAbscore();
     _tabController = TabController(length: 2, vsync: this);
  }


  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchArmsShoulder() async{
    final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allvideos = box.values.toList();

    final List<Addvideomodel> filteredVideos =
     allvideos.where((video) => video.selectedCategory.contains('Arms & Shoulder'))
    .toList();

    setState(() {
      ArmsShoulderVideos = filteredVideos;
    });
  }

  Future<void> _fetchAbscore() async{
    final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allvideos = box.values.toList();

    final List<Addvideomodel> filteredVideos =
     allvideos.where((video) => video.selectedCategory.contains('Abs & core'))
    .toList();

    setState(() {
      AbsCorevideos = filteredVideos;
    });
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
            tabs: const [
              Tab(text: 'Arms & Shoulders',),
              Tab(text: 'Abs & Core',),

            ]
            ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
               Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ArmsShoulderVideos.length,
                  itemBuilder: (context, index) {
                    final video = ArmsShoulderVideos[index];
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
                      onTap: () {
                        Navigator.push(context,
                         MaterialPageRoute(
                          builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                            discription: video.discription,
                             title:video.title,
                              videoUrl:video. videoUrl,
                               imageBytes:video. imageBytes,
                                time:video.time, 
                                selectedCategory:video.selectedCategory,
                                 index: index
                                ),
                               ),
                             ),
                           );
                      },
                    );
                  },
                 ),
                ),
              ],
            ),
            Column(
              children: [
               Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: AbsCorevideos.length,
                  itemBuilder: (context, index) {
                    final video = AbsCorevideos[index];
                    return ListTile(
                      leading: Container(
                        width: 100,
                        height: 200,
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
                        Navigator.push(context,
                         MaterialPageRoute(
                          builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                            discription: video.discription,
                             title:video.title,
                              videoUrl:video. videoUrl,
                               imageBytes:video. imageBytes,
                                time:video.time, 
                                selectedCategory:video.selectedCategory,
                                 index: index
                                ),
                               ),
                             ),
                           );
                      },
                    );
                  },
                 ),
                ),
              ],
            )
          ]),
      ),
    );
  }
}