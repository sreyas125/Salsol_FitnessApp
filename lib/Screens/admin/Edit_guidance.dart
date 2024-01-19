// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';

class EditGuidance extends StatefulWidget {
  final Guidance guidance;
  const EditGuidance({super.key,required this.guidance});

  @override
  State<EditGuidance> createState() => _EditGuidanceState();
}

class _EditGuidanceState extends State<EditGuidance> {
  late TextEditingController _titleController;
  late TextEditingController _paragraphController;
  bool _isEditing = false;
 
   @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.guidance.title);
    _paragraphController = TextEditingController(text: widget.guidance.paragraph);
  }

 void _deleteGuidance() async{
  final Box<Guidance> guidanceBox = await Hive.openBox<Guidance>('Guidance');
  showDialog(
    context: context,
     builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are You sure you want to delete the guidance'),
        actions: [
          TextButton(
            onPressed: ()async{
              await guidanceBox.deleteAt(guidanceBox.keys.toList().indexOf(widget.guidance));
              Navigator.pop(context);
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
  await guidanceBox.deleteAt(guidanceBox.keys.toList().indexOf(widget.guidance));
  Navigator.pop(context);
 }

 void _SaveChanges() {
  setState(() {
    _isEditing = false;
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            height: 200,
            width: 200,
            child: GestureDetector(
              onTap: () {
                
              },
              child: Center(
                child: widget.guidance.imageBytes != null
                ?Image.memory(
                  widget.guidance.imageBytes!,
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
                      widget.guidance.title = value;
                    });
                },
                decoration: InputDecoration(
                  labelText: "Title",
                  border:const OutlineInputBorder(),
                  suffixIcon: _isEditing?IconButton(
                    onPressed: (){
                      _SaveChanges();
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
                 widget.guidance.paragraph = value;
               });
             },
             maxLines: 20,
             decoration: InputDecoration(
              labelText: 'Paragraph',
              border: const OutlineInputBorder(),
              suffixIcon: _isEditing
              ? IconButton(
                onPressed: (){
                _SaveChanges();
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
    ),
  );
 }
}