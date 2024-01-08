import 'package:flutter/material.dart';

class VideoRefactoring extends StatefulWidget {
  const VideoRefactoring({super.key});

  @override
  State<VideoRefactoring> createState() => _VideoRefactoringState();
}

class _VideoRefactoringState extends State<VideoRefactoring> {
    bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
      return Stack(
                   children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.asset('lib/Assets/hq720.webp',
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
                       decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 172, 156, 156),
                       ),
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                          icon: Icon(
                            isBookmarked?Icons.bookmark:Icons.bookmark_border_outlined,
                            color: isBookmarked ? Colors.black : Colors.white,
                            ),
                          ),
                      )),
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 120,
                      child: Center(
                        child: Text('Min HIT:Abs',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                      ),
                      Positioned(
                          bottom: 40,
                          left: 0,
                          right: 90,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                '22 min - Beginner',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                 ),
              ),
          ),               
      ],      
    );
  }
}