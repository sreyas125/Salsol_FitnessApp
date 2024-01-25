// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';

class EditGuidance extends StatefulWidget {
  final Guidance ?guidance;
  const EditGuidance({super.key,this.guidance});

  @override
  State<EditGuidance> createState() => _EditGuidanceState();
}

class _EditGuidanceState extends State<EditGuidance> {
  List<Guidance>guidanceList = [];
 
   @override
  void initState() {
    super.initState();
    fetchGuidance();
  }

   Future<void>fetchGuidance() async{
    final box = await Hive.openBox<Guidance>('Guidance');
    setState(() {
      guidanceList = box.values.toList();
    });
   }

   Future<void>saveUpdatedDetails(int index) async{
    final box = await Hive.openBox<Guidance>('Guidance');
    await box.put(index, guidanceList[index]);
   }

 void _deleteGuidance(int index,context) async{
  return showDialog(
    context: context,
     builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are You sure you want to delete the guidance'),
        actions: [
          TextButton(
            onPressed: (){
              deletealldetails(index);
              Navigator.pop(context);
            }, child: const Text('Delete')
            ),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const Text('Cancel')
            ),
        ],
      );
     });
 }

 Future<void> deletealldetails(int index)async{
  final Box = await Hive.openBox<Guidance>('Guidance');
  await Box.deleteAt(index);

  setState(() {
    guidanceList.removeAt(index);
  });
 }

 void _SaveUpdatedDetails(int index)async {
  final box = await Hive.openBox<Guidance>('Guidance');
  await box.put(index,guidanceList[index]); 
 }

 void _editImage(int index) async{
  final PickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(PickedFile != null){
    final imageBytes = await PickedFile.readAsBytes();
    final box = await Hive.openBox<Guidance>('Guidance');
    final  image = guidanceList[index];

    final Uint8List? currentImageBytes = image.imageBytes;
    if(currentImageBytes != null){
      await box.put(index, image);

      setState(() {
        guidanceList[index] = image;
      });
    }
  }
 }

 editVideoDetails(int index){
  showModalBottomSheet(context: context,
   builder: (BuildContext context){
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: guidanceList[index].title,
            decoration:  InputDecoration(
              labelText: 'title',
              border: OutlineInputBorder(),
              ),
              onChanged: (newValue){
                setState(() {
                  guidanceList[index].title=newValue;
                });
              },
          ),
          TextFormField(
            initialValue: guidanceList[index].paragraph,
            decoration: const InputDecoration(
              labelText: 'Paragraph',border: OutlineInputBorder(),
            ),
            onChanged: (newValue){
              setState(() {
                guidanceList[index].paragraph = newValue;
              });
            },
          ),
          const SizedBox(height: 16.0,),
          ElevatedButton(onPressed: (){
            saveUpdatedDetails(index);
            Navigator.pop(context);
          }, child: const Text('Save'))
        ]),
    );
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Edit Guidance'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: ListView.builder(
        itemCount: guidanceList.length,
        itemBuilder: (context, index) {
          final guidances = guidanceList[index];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              height: 200,
              width: 200,
              child: GestureDetector(
                onTap: () {
                  _editImage(index);
                },
                child: Center(
                  child: guidances.imageBytes != null
                  ?Image.memory(
                   guidances.imageBytes,
                  fit: BoxFit.cover,
                  )
                   :const Icon(CupertinoIcons.camera_on_rectangle_fill)
                ),
              ),
            ),
           const SizedBox(height: 20,),
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text('Title: ${guidances.title}'),
             Text('Paragraph: ${guidances.paragraph}'),

             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  
                }, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){
                  deletealldetails(index);
                }, icon: const Icon(Icons.delete)),
              ],
             )
            ]
           ),
          ],
        );
       }
      ),
  );
 }
}