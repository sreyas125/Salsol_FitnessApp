import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class WorkOutImage extends StatefulWidget {

  final Uint8List? workimage;
  final String worktitle;
  final String times;
  final Function() nav;
  final Function(bool isBookmarked) onBookmarChanged;
  final ValueNotifier<List<Addvideomodel>> addVideoListNotifier;
  final int index;
  final String selectedCategory;
  final String videoUrl;
  

 
  const WorkOutImage({
    super.key,
    required this.workimage,
    required this.worktitle,
    required this.times,
    required this.nav,
    required this.onBookmarChanged,
    required this.addVideoListNotifier,
    required this.index, 
    required this.videoUrl,
    required this.selectedCategory,
    });

  @override
  State<WorkOutImage> createState() => _WorkOutImageState();
}

class _WorkOutImageState extends State<WorkOutImage> {
  bool isBookmarked = false;
   late ValueNotifier<List<Addvideomodel>> addvideoListNotifier;
   

   @override
  void initState() {
    super.initState();
    addvideoListNotifier = widget.addVideoListNotifier;
  }
   
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: widget.nav,
               child: Stack(
                   children: [
                   Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.memory(
                       widget.workimage!,
                       fit: BoxFit.cover,
                       width: 230,
                       height: 300,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 40,
                        height: 40,
                       decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 172, 156, 156),
                       ),
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              print('tapped');
                              isBookmarked = !isBookmarked;
                                 widget.onBookmarChanged(isBookmarked);
                              //   if(isBookmarked){
                              //     widget.onBookmarChanged(true);

                              //     SavedWorkout workout = SavedWorkout(
                              //       discription: widget.worktitle,
                              //        imageBytes: widget.workimage!,
                              //         index: widget.index, 
                              //         selectedCategory: widget.selectedCategory,
                              //          time: widget.times,
                              //           title:widget.worktitle,
                              //            videoUrl: widget.videoUrl,
                              //            );
                              //     saveWorkouts(workout);
                              //     widget.addVideoListNotifier.value=[...widget.addVideoListNotifier.value, ];
                              // }else{
                              //   widget.onBookmarChanged(false);
                              //   deleteFromsavedWorkouts(widget.index);
                              //   widget.addVideoListNotifier.value = 
                              //   [...widget.addVideoListNotifier.value]
                              //   ..removeWhere((workout) => workout.index == widget.index);
                              // }
                            });
                          },
                          icon: Icon(
                            isBookmarked
                            ?Icons.bookmark
                            :Icons.bookmark_border_outlined,
                            color: isBookmarked==true ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 40,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 30,right: 0,bottom: 60),
                          child: Container(
                             padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                            child: Text(
                              widget.worktitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
          Positioned(
             bottom: 30,
               left: 9,
               right: 100,
               top: 200,
                 child: Center(
                 child: Padding(
                   padding: const EdgeInsets.only(right: 0),
                   child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                     child: Text(
                       widget.times,
                         style: const TextStyle(
                          color: Color.fromARGB(255, 154, 147, 147),
                        fontSize: 14,
                     fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}