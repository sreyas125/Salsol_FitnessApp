import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddGuidance extends StatefulWidget {
  const AddGuidance({super.key});

  @override
  State<AddGuidance> createState() => _AddGuidanceState();
}

class _AddGuidanceState extends State<AddGuidance> {
  File? image;
   Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Add Guidance'),
        leading: BackButton(),
      ),
      body: Column(
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
                  child: Center(
                   child: Icon(
                    CupertinoIcons.camera_on_rectangle_fill),
                  ),
                )
               
              ),
            ),
          )
        ],
      ),
    );
  }
}