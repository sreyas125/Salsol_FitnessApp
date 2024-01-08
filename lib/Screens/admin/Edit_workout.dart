import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salsol_fitness/Screens/admin/home_admin.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class EditWorkout extends StatefulWidget {
  EditWorkout({Key? key});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  List<Addvideomodel> videoList = [];

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

  void _editVideoDetails(int index){
    showModalBottomSheet(
      context: context,
       builder: (BuildContext context){
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: videoList[index].title,
                decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    videoList[index].title = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0,),
              TextFormField(
                initialValue: videoList[index].discription,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    videoList[index].discription = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0,),
              TextFormField(
                initialValue: videoList[index].time,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    videoList[index].time = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0,),
              ElevatedButton(onPressed: (){
                saveUpdatedDetails(index);
                Navigator.pop(context);
              }, child: Text('Save'),)
            ],
          ),
        );
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

  void _deleteVideoDetails(int index) {
    showDialog(
      context: context,
       builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are You sure You Want to delete this details?'),
          content: Text('This Action will delete the workout details'),
          actions: [
            TextButton(
              onPressed: (){
                deleteDetails(index);
                Navigator.of(context).pop();
            }, child: Text('Delete'),)
          ],
        );
       });
  }
   Future<void> deleteDetails(int index) async{
    final Box = await Hive.openBox<Addvideomodel>('videos');
    await Box.deleteAt(index);

    setState(() {
      videoList.removeAt(index);
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdministrationScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Edit WorkOuts'),
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (BuildContext context, int index) {
          final video = videoList[index];
          return Padding(
            padding: EdgeInsets.all(8.0),
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
                  SizedBox(height: 10),
                  Text('Title: ${video.title}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Description: ${video.discription}'),
                  Text('Time: ${video.time}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          _editVideoDetails(index); 
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(onPressed: (){
                        _deleteVideoDetails(index);
                      }, icon: Icon(Icons.delete_outline_rounded))
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
