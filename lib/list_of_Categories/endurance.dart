import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
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
     VideoList: [],
       selectedCategories: selectedCategories
       );
  }

  @override
  State<Endurance> createState() => _EnduranceState();
}

class _EnduranceState extends State<Endurance> with SingleTickerProviderStateMixin {
  List<Addvideomodel>EnduranceVideos=[];
  List<Addvideomodel>YogaVideos=[];
  late TabController _tabController;

  @override
  void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
  _fetchdata();
  _fetchyogadata();
  }

  Future<void> _fetchdata() async{
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory == 'Endurance')
        .toList();

         setState(() {
      EnduranceVideos = filteredVideos;
    });

  }
  Future<void> _fetchyogadata() async{
     final box = await Hive.openBox<Addvideomodel>('videos');
    final List<Addvideomodel> allVideos = box.values.toList();

    final List<Addvideomodel> filteredVideos = allVideos
        .where((video) => video.selectedCategory == 'Yoga')
        .toList();

         setState(() {
     YogaVideos = filteredVideos;
    });

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildEnduranceTab(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.VideoList.length,
      itemBuilder: (context,index){
        final video = widget.VideoList[index];
        return ListTile(
          title: Text(video.title),
          subtitle: Text(video.discription),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Colors.grey,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
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
                // if(widget.VideoList.isEmpty)
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text('data'),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: YogaVideos.length,
                  itemBuilder: (context,index){
                     final videos = YogaVideos[index];
                     debugPrint(videos.title);
                    return ListTile(
                      leading: Container(
                         width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(videos.imageBytes
                              ),
                            ),
                          ),
                      ),
                      title: Text(videos.title),
                        subtitle: Text(videos.time),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreenOne(
                            addvideomodel: Addvideomodel(
                              discription:videos.discription,
                               title:videos.title,
                                videoUrl:videos.videoUrl,
                                 imageBytes:videos.imageBytes,
                                  time:videos.time,
                                   selectedCategory: videos.selectedCategory,
                                    index: index,
                                    )
                                  ),
                               )
                            );
                         }
                       );
                    }),
              ],
            )
          ]),
      ),
    );
  }
}