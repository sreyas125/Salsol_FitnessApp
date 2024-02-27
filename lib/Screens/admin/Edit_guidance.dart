// ignore_for_file: use_build_context_synchronously, unused_element

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
              deletealldetails(index,context);
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
Future<void> deletealldetails(int index,BuildContext context) async {
  final Box<Guidance> guidanceBox = await Hive.openBox<Guidance>('Guidance');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are you sure you want to delete this details?'),
        actions: [
          TextButton(
            onPressed: () async {
              await guidanceBox.deleteAt(index);
              setState(() {
                guidanceList.removeAt(index);
              });
              Navigator.of(context).pop(); 
            },
            child: const Text('Delete',style: TextStyle(color: Colors.red),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
 // ignore: non_constant_identifier_names
 void _SaveUpdatedDetails(int index)async {
  final box = await Hive.openBox<Guidance>('Guidance');
  await box.put(index,guidanceList[index]); 
 }
 void _editImage(int index) async{
  // ignore: non_constant_identifier_names
  final PickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(PickedFile != null){
    final imageBytes = await PickedFile.readAsBytes();
    final box = await Hive.openBox<Guidance>('Guidance');
    final  image = guidanceList[index];

    // ignore: unnecessary_nullable_for_final_variable_declarations
    final Uint8List? currentImageBytes = image.imageBytes;
    if(currentImageBytes != null){
       await box.deleteAt(index);
    }
      image.imageBytes = imageBytes;
      await box.put(index, image);
      setState(() {
        guidanceList[index] = image;
      });
   }
 }
editVideoDetails(int index){
  showDialog(
    context: context,
   builder: (context){
    return AlertDialog(
      title: const Text('Edit'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
               initialValue: guidanceList[index].title,
               decoration: const InputDecoration(
                 labelText: 'title',
                 border: OutlineInputBorder(),
                 ),
                 onChanged: (newValue){
                   setState(() {
                     guidanceList[index].title=newValue;
                   });
                 },
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
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
           ),
           const SizedBox(height: 16.0,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ElevatedButton(onPressed: (){
               saveUpdatedDetails(index);
               Navigator.pop(context);
             }, child: const Text('Save')),
           )
         ]),
      ),
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
    body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: guidanceList.map((guidance) {
            final index = guidanceList.indexOf(guidance);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                        // ignore: unnecessary_null_comparison
                        child: guidance.imageBytes != null
                            ? Image.memory(
                                guidance.imageBytes,
                                fit: BoxFit.cover,
                              )
                            : const Icon(CupertinoIcons.camera_on_rectangle_fill),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title: ${guidance.title}'),
                      Text('Paragraph: ${guidance.paragraph}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              editVideoDetails(index);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              deletealldetails(index,context);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
}
