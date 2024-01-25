import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';

class GuidancePage extends StatefulWidget {
  const GuidancePage({super.key});

  @override
  State<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {
 late Box<Guidance> guidanceBox;
 String? guidanceTitle;

  Future<void> openGuidanceBox() async{
    guidanceBox = await Hive.openBox<Guidance>('Guidance');
    getGuidanceTitle();
  }
  Future<void> getGuidanceTitle() async{
    if(guidanceBox.isNotEmpty){
      final Guidance firstGuidance = guidanceBox.values.first;
      setState(() {
        guidanceTitle = firstGuidance.title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading:  const BackButton(),
      ),
       body: Column(
        children: [
          Text(guidanceTitle ?? ''),
        ],
       ),
    );
  }
}