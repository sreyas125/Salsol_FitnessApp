// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_nullable_for_final_variable_declarations, unused_element

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/widgets/Functions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EditWorkout extends StatefulWidget {
   EditWorkout({Key? key});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  List<Addvideomodel> videoList = [];
  YoutubePlayerController? _playerController;
  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

 

  Future<void> fetchVideos() async {
    final box = await Hive.openBox<Addvideomodel>('videos');
    setState(() {
      videoList = box.values.toList();
    });
  }
     Future<void> saveUpdatedDetails(int index) async{
      final box = await Hive.openBox<Addvideomodel>('videos');
      await box.put(index, videoList[index]);
     }

  void _editImage(int index) async{
   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final box = await Hive.openBox<Addvideomodel>('videos');
      final video = videoList[index];
      
     final Uint8List? currentImageBytes = video.imageBytes;
     if(currentImageBytes != null){
      await box.deleteAt(index);
     }     
      video.imageBytes = imageBytes;
      await box.put(index, video);

      setState(() {
        videoList[index] = video;
      });
    }
  }
 String _selectedCategory='';
  void editCategory(int index){
    showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(0, 0, 0, 0),
    items: [
      PopupMenuItem(
        child: ListTile(
          title: const Text('Yoga'),
          onTap: () {
            _updateCategoryAndPop('Yoga', index);
          },
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          title: const Text('Endurance'),
          onTap: () {
            _updateCategoryAndPop('Endurance', index);
          },  
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          title: const Text('Arms & Shoulder'),
          onTap: () {
            _updateCategoryAndPop('Arms & Shoulder', index);
          },  
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          title: const Text('Abs & Core'),
          onTap: () {
            _updateCategoryAndPop('Abs & Core', index);
          },  
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          title: const Text('Mindfulness'),
          onTap: () {
            _updateCategoryAndPop('Mindfulness', index);
          },  
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          title: const Text('Strength'),
          onTap: () {
            _updateCategoryAndPop('Strength', index);
          },  
        ),
      ),
       PopupMenuItem(
        child: ListTile(
          title: const Text('Mobility'),
          onTap: () {
            _updateCategoryAndPop('Mobility', index);
          },  
        ),
      ),
       PopupMenuItem(
        child: ListTile(
          title: const Text('Overall Fitness'),
          onTap: () {
            _updateCategoryAndPop('Overall Fitness',index);
          },  
        ),
      ),
    ],
    elevation: 8.0,
  );
  }
   Future<void> _updateCategoryAndPop(String category,int index) async{
     videoList[index].selectedCategory = category;

     final box = await Hive.openBox<Addvideomodel>('videos');
     await box.put(index, videoList[index]);
     // ignore: use_build_context_synchronously
     Navigator.of(context).pop();
   }

    Future<void>_editVideoUrl(int index) async{
      String? updatedVideoUrl = await showVideoUrlEditDialog(context);
    if(updatedVideoUrl != null){
      final box = await Hive.openBox<Addvideomodel>('videos');
      final video = videoList[index];
      video.videoUrl = updatedVideoUrl;
      await box.put(index, video);
      setState(() {
        videoList[index] = video;
      });

      _playerController?.load(updatedVideoUrl);
    }
     }

     Future<String?> showVideoUrlEditDialog(BuildContext context) async{
      TextEditingController _videoUrlController = TextEditingController();
      return showDialog<String?>(
        context: context,
         builder: (BuildContext context){
          return AlertDialog(
            title: Text('Edit Video URL'),
            content: TextField(
              controller: _videoUrlController,
              decoration: InputDecoration(labelText: 'Enter the New URL'),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context,_videoUrlController.text);
              }, child: Text('Save'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context,null);
              }, child: Text('Cancel'),)
            ],
          );
         });
     }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        leading: BackButton(),
        title: const Text('Edit WorkOuts'),
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (BuildContext context, int index) {
          final video = videoList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _editImage(index); 
                    },
                    child: Image.memory(
                      video.imageBytes,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title: ${video.title}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10,),
                  Text('Description: ${video.discription}'),
                  const SizedBox(height: 10,),
                  Text('Time: ${video.time}'),
                    ],
                  ),
                    Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: TextFormField(
                          readOnly: true,
                          controller: TextEditingController(text: video.selectedCategory ?? ''),
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          onTap: (){
                            editCategory(index);
                          },
                        ),
                   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          editVideoDetails(index,context,videoList, setState,saveUpdatedDetails); 
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: (){
                      deleteVideoDetails(index, context,setState);
                      }, icon: const Icon(Icons.delete_outline_rounded)),
                      IconButton(onPressed: (){
                        _editVideoUrl(index);
                      }, icon: const Icon(Icons.link))
                    ],
                  ),
                  const Divider(),  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
