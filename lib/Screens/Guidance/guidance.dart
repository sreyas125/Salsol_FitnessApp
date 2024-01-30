// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/Guidance/guidancePage.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';

class GuidanceTab extends StatefulWidget {
  const GuidanceTab({super.key});

  @override
  State<GuidanceTab> createState() => _GuidanceTabState();
}

class _GuidanceTabState extends State<GuidanceTab> {
  late Box<Guidance>guidanceBox;

  @override
  void initState() {
  super.initState();
   try{
    guidanceBox = Hive.box<Guidance>('Guidance');
   }catch(error){
    debugPrint('Error opening the guidance Box $error');
   }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
             children: [
               const Row(
                 children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40,left: 20),
                       child: Text(
                      'Featured Tips',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                     ),
                   ],
                 ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20,top: 10),
                          child: Text('Nutrition & healthy habits to help you feel\ngood all-around',
                          style: TextStyle(fontSize: 20,color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                   guidanceBox != null 
                   ?Padding(
                     padding: const EdgeInsets.only(top: 30,left: 20),
                     child: SizedBox(
                      height: 650,
                       child: ListView.builder(            
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                         itemCount: guidanceBox.length,
                          itemBuilder: (BuildContext context,int index) {
                            final Guidance = guidanceBox.getAt(index);
                            return SizedBox(
                              height: 300,
                              width: 380,
                               child: GestureDetector(
                                 onTap: (){
                                    Navigator.of(context).push(
                                     MaterialPageRoute(builder: (context) =>  GuidancePage(guidanceIndex: index,),));
                                 },
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Expanded(
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Container(
                                               height: 200,
                                               width: 380,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                    ),
                                                ),
                                           child: Image.memory(
                                             Guidance!.imageBytes,
                                             fit: BoxFit.cover,
                                           ),
                                         ),
                                       ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(Guidance.title,
                                       style: const TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                            );
                         },
                      ),
                     ),
                   )
                :const CircularProgressIndicator(),
             ],
          ),
       );
   }
}