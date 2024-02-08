import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
    List<Addvideomodel>equipmentvideos=[];
    List<Addvideomodel>noequipmentvideos=[];

      Future<void> _fetchFullequipmentsdata() async{
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory.contains('Full Equipment'))
        .toList();

         setState(() {
      equipmentvideos = filteredVideos;
    });
  }

   Future<void> _fetchNoequipmentsdata() async{
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory.contains('No Equipment'))
        .toList();

         setState(() {
      noequipmentvideos = filteredVideos;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFullequipmentsdata();
    _fetchNoequipmentsdata();
    _tabController = TabController(length: 2, vsync: this);
    
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
              Tab(text: 'Full Equipment',),
              Tab(text: 'No Equipment',)
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
                    itemCount: equipmentvideos.length,
                    itemBuilder: (context,index){
                       final video = equipmentvideos[index];
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
                          Navigator.push(context, 
                          MaterialPageRoute(
                            builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                              discription:video.discription,
                               title:video.title,
                                videoUrl:video.videoUrl,
                                 imageBytes:video.imageBytes,
                                  time:video.time,
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
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                     shrinkWrap: true,
                    itemCount: noequipmentvideos.length,
                    itemBuilder: (context,index){
                       final video = noequipmentvideos[index];
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
                          Navigator.push(context, 
                          MaterialPageRoute(
                            builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                              discription:video.discription,
                               title:video.title,
                                videoUrl:video.videoUrl,
                                 imageBytes:video.imageBytes,
                                  time:video.time,
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
                ),
              ],
            ),

          ]),
       ));
  }
}