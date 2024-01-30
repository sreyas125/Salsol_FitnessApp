import 'package:flutter/cupertino.dart';
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
  List _bookmarkedvideos = [];
  late Box<SavedWorkout> savedworkoutbox;

  @override
  void initState() {
    super.initState();
    // Open the 'saved_workouts' box
    Hive.openBox<SavedWorkout>('saved_workouts').then((box) {
      savedworkoutbox = box;

      // Load data from the box and update the state
      _bookmarkedvideos = savedworkoutbox.values.toList();

      // Force a rebuild to update the UI
      setState(() {});
    });

    if (widget.bookmarkedVideos != null) {
      _bookmarkedvideos = List.from(widget.bookmarkedVideos!);
    }
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
              child: Text('No videos Available'),
            )
          else
            Expanded(
              child: ListView.builder(
                  itemCount: _bookmarkedvideos.length,
                  itemBuilder: (context, index) {
                    final video = _bookmarkedvideos[index];
                    return ListTile(
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                      leading: CircleAvatar(backgroundImage:MemoryImage(video.imageBytes)),
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
                  }),
            ),
        ],
      ),
    );
  }
}
