// ignore_for_file: non_constant_identifier_names, unused_local_variable, file_names
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
  Uint8List? _imageBytes;
  String? _title;
  String? _Paragraph;

   Future<void> _pickImage() async {
    final PickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      debugPrint('going to enter');
    if(PickedFile != null){
        debugPrint('Entered');
      final imageBytes = await PickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
      await Hive.box('images').put('image', imageBytes);
        debugPrint('successfully');
    }
  }

  Future<void> _saveGuidanceDetails() async{
    if(_imageBytes !=null &&
     _title != null && 
     _Paragraph != null){
  final Guidances = Guidance(
    title: _title!,
     paragraph: _Paragraph!,
      imageBytes: _imageBytes!
      );

      final Box<Guidance>readingBox = Hive.box<Guidance>('Guidance');
        await readingBox.add(Guidances);
        debugPrint('Successfully');
        setState(() {
          _Paragraph=' ';
          _imageBytes=null;
          _title=' ';
        });
    }
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
                    color: Colors.black
                    ),
                  ),
                  height: 200,
                  width: 200,
                  child: GestureDetector(
                    onTap: () {
                     _pickImage();
                    },
                    child:  Center(
                     child: _imageBytes != null
                      ?Image.memory(
                        _imageBytes!,
                        fit: BoxFit.cover,
                        )
                      : const Icon(CupertinoIcons.camera_on_rectangle_fill),
                    ),
                  )
                 
                ),
              ),
            ),
          const SizedBox(height: 20,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                        _title = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        _Paragraph = value;
                      });
                    },
                    maxLines: 20,
                    decoration: const InputDecoration(
                      labelText: 'paragraph',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: _saveGuidanceDetails,
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