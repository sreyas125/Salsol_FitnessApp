import 'package:flutter/material.dart';

class GuidanceTab extends StatefulWidget {
  const GuidanceTab({super.key});

  @override
  State<GuidanceTab> createState() => _GuidanceTabState();
}

class _GuidanceTabState extends State<GuidanceTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              height: 200,
                              width: 190,
                              child: InkWell(
                                onTap: (){

                                },
                                child: Image.asset('lib/Assets/A_fat_cartoonman_jogging.jpeg'))),
                          ),
                         const SizedBox(width: 5,),
                          Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,top: 20),
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              width: 190,
                              height: 200,
                              child: InkWell(
                                onTap: (){

                                },
                                child: Image.asset('lib/Assets/Weight_Loss_Girl.jpeg'))),
                          )
                        ],
                      ),
                        ],
                      ),
                     const Padding(
                        padding: EdgeInsets.only(left: 20,top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Can-do With Confidents?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                  ),
                                ),
                                 Padding(
                                   padding: EdgeInsets.only(left: 55),
                                   child: Text('Ramp Up the Right Way',
                                     style: TextStyle(
                                      fontSize: 15,
                                       fontWeight: FontWeight.w500
                                      ),
                                    ),
                                 )
                              ],
                            ),
                            SizedBox(height: 6,),
                             Row(
                          children: [
                            Text('Coaching',
                            style: TextStyle(
                              color: Colors.grey),
                              ),
                              SizedBox(width: 153,),
                              Text('Coaching',
                            style: TextStyle(
                              color: Colors.grey),
                              ),
                            ],
                           ),
                         ],
                       ),
                      ),
                    ],
                  )
                ],
              );
  }
}