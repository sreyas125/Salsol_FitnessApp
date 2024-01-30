import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';

class GuidancePage extends StatefulWidget {
  final int guidanceIndex;
  const GuidancePage({super.key,required this.guidanceIndex});

  @override
  State<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {

  late Box<Guidance> guidanceBox;
  String? guidanceTitle;
  String? guidanceParagraph;
  Uint8List? guidanceImageBytes;
  @override
  void initState() {
    super.initState();
    debugPrint('OpenGuidanceBox');
    openGuidanceBox();
  }

  Future<void> openGuidanceBox() async{
    guidanceBox = await Hive.openBox<Guidance>('Guidance');
    getGuidanceDetails();
  }
  Future<void> getGuidanceDetails() async{
    if(widget.guidanceIndex >= 0 && widget.guidanceIndex < guidanceBox.length){

      final Guidance selectedGuidance = guidanceBox.getAt(widget.guidanceIndex)!;
      setState(() {
        guidanceTitle = selectedGuidance.title;
        guidanceParagraph = selectedGuidance.paragraph;
        guidanceImageBytes = selectedGuidance.imageBytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back))
      ),
       body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 0,right: 200),
            child: Text(guidanceTitle ?? 'No guidance',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              ),
            ),
          ),
         const SizedBox(height: 20,),
          if(guidanceImageBytes != null)
          Image.memory(
            guidanceImageBytes!,
            height: MediaQuery.of(context).size.height/2,
            width: double.infinity,
           fit: BoxFit.cover, ),
          const SizedBox(height: 50,),
          Text(guidanceParagraph ?? 'no paragraph')
        ],
       ),
    );
  }
}