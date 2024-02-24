import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/videoScreens/video_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';

class SavedWorkouts extends StatefulWidget {
  final List<Addvideomodel>? bookmarkedVideos;

  const SavedWorkouts({Key? key, this.bookmarkedVideos}) : super(key: key);

  @override
  State<SavedWorkouts> createState() => _SavedWorkoutsState();
}

class _SavedWorkoutsState extends State<SavedWorkouts> {
  late ValueNotifier<List<Addvideomodel>> addvideoListNotifier;
  List _bookmarkedvideos = [];
  late Box<SavedWorkout> savedworkoutbox;

  @override
  void initState() {
    super.initState();
    _fetchSaved();
  }

Future<void> _fetchSaved() async {
  await Hive.openBox<SavedWorkout>('saved_workouts').then((box) {
    setState(() {
      savedworkoutbox = box;
      _bookmarkedvideos = savedworkoutbox.values.toList();
      _bookmarkedvideos.removeWhere((video) =>
      _bookmarkedvideos.any((v) => v.index == video.index) &&
      _bookmarkedvideos.indexOf(video) != _bookmarkedvideos.lastIndexOf(video));
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Saved Workouts'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          if (_bookmarkedvideos.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(),
                child: Text('No videos Available'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                  itemCount: _bookmarkedvideos.length,
                  itemBuilder: (context, index) {
                    final video = _bookmarkedvideos[index];
                    return ListTile(
                      // trailing: IconButton(
                      //   onPressed: () async{
                      //   bool deleteConfirmed = await showDialog( 
                      //     context: context,
                      //      builder: (BuildContext context) {
                      //        return AlertDialog(
                      //         title: const Text('Delete video'),
                      //          content: const Text('Are you sure'),
                      //          actions: [
                      //           TextButton(onPressed: (){
                      //             Navigator.of(context).pop(false);
                      //           },
                      //            child: const Text('Cancel')),
                      //             TextButton(onPressed: () => Navigator.of(context).pop(true),
                      //              child:const Text('Delete'),
                      //              ),
                      //            ],
                      //          );
                      //        }
                      //     );
                      //      if(deleteConfirmed == true){ 
                      //       setState(() {
                      //         _bookmarkedvideos.removeAt(index);
                      //       });
                      //       savedworkoutbox.deleteAt(index);
                      //      }
                      // },
                      //  icon:const Icon(Icons.delete)),
                      leading:Container(
                        width: 50,
                        height: 150,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreenOne(
                              addvideomodel: Addvideomodel(
                                discription: video.discription,
                                title: video.title,
                                videoUrl: video.videoUrl,
                                imageBytes: video.imageBytes,
                                time: video.time,
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
    );
  }
}
