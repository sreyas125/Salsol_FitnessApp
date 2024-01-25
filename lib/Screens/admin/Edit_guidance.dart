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
  late TextEditingController _titleController;
  late TextEditingController _paragraphController;
  bool _isEditing = false;
 
   @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.guidance!.title);
    _paragraphController = TextEditingController(text: widget.guidance!.paragraph);
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
              Navigator.pop(index,);
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
 }

 void _SaveUpdatedDetails(int index)async {
  final box = await Hive.openBox<Guidance>('Guidance');
  await box.put(index,guidanceList[index]); 
  setState(() {
    _isEditing = false;
  });
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
                  child: widget.guidance!.imageBytes != null
                  ?Image.memory(
                    widget.guidance!.imageBytes!,
                  fit: BoxFit.cover,
                  )
                   :const Icon(CupertinoIcons.camera_on_rectangle_fill)
                ),
              ),
            ),
           const SizedBox(height: 20,),
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  enabled: _isEditing,
                  onChanged: (value){
                      setState(() {
                        widget.guidance!.title = value;
                      });
                  },
                  decoration: InputDecoration(
                    labelText: "Title",
                    border:const OutlineInputBorder(),
                    suffixIcon: _isEditing
                    ?IconButton(
                      onPressed: (){
                        _SaveUpdatedDetails(index);
                      },
                       icon: const Icon(Icons.save)
                       )
                       :IconButton(
                        onPressed: (){
                         setState(() {
                           _isEditing = true;
                         });
                       }, 
                       icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 20,),
              TextFormField(
                controller: _paragraphController,
               onChanged: (value) {
                 setState(() {
                   widget.guidance!.paragraph = value;
                 });
               },
               maxLines: 20,
               decoration: InputDecoration(
                labelText: 'Paragraph',
                border: const OutlineInputBorder(),
                suffixIcon: _isEditing
                ? IconButton(
                  onPressed: (){
                  _SaveUpdatedDetails(index);
                }, icon: const Icon(Icons.save)
                )
                :IconButton(
                  onPressed: (){
                  setState(() {
                    _isEditing = true;
                  });
                },
                 icon: const Icon(Icons.edit),
                 ),
                ),
              )
            ],
          )
        ],
     );
   }
      ),
  );
 }
}