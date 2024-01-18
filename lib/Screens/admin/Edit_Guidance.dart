// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';


class AddGuidance extends StatefulWidget {
  const AddGuidance({super.key});

  @override
  State<AddGuidance> createState() => _AddGuidanceState();
}

class _AddGuidanceState extends State<AddGuidance> {
  File? image;
  TextEditingController titleController = TextEditingController();
  TextEditingController paragraphController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

   Future pickImage() async{
    final PickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(PickedImage != null){
      setState(() {
        image = File(PickedImage.path);
      });
     }
   }

   Future<void> SaveGuidance() async{
    if(titleController.text.isEmpty || 
    paragraphController.text.isEmpty ||
     image == null) {
      return;
    }
     final guidanceBox = await Hive.openBox<Guidance>('Guidance');
      final Uint8List imageBytes = await image!.readAsBytes();

      final newGuidance = Guidance(
        title: titleController.text,
        paragraph: paragraphController.text,
        Category: categoryController.text, 
        imageBytes: imageBytes,
      );

      await guidanceBox.add(newGuidance);
      await guidanceBox.close();

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Add Guidance'),
        leading:const  BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                decoration: BoxDecoration(
                  border:Border.all(
                    color: Colors.black),
                    ),
                  height: 200,
                  width: 200,
                  child: GestureDetector(
                    onTap: () {
                     pickImage();
                    },
                    child:  Center(
                     child: image != null
                      ?Image.file(image!,fit: BoxFit.cover,)
                      : const Icon(CupertinoIcons.camera_on_rectangle_fill),
                    ),
                  )
                 
                ),
              ),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: paragraphController,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      labelText: 'paragraph',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: SaveGuidance,
                 child: const Text('Save'),
                 )
              ],
            )
          ],
        ),
      ),
    );
  }
}