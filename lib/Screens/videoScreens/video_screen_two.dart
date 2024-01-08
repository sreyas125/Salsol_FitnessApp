import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/youtube/video_player.dart';

class VideoScreenTwo extends StatefulWidget {
  const VideoScreenTwo({super.key});

  @override
  State<VideoScreenTwo> createState() => _VideoScreenTwoState();
}

class _VideoScreenTwoState extends State<VideoScreenTwo> {
  late final String videoId = "UNa7kaCWCLs";
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Stack(
        children:[
           Column(
             children: [
               SizedBox(
                height: halfScreenHeight,
                 child: Stack(
                  fit: StackFit.expand,
                   children: [
                     Image.asset(
                       'lib/Assets/hq721_(1).webp',
                     width: double.infinity,
                     fit: BoxFit.cover
                     ),
                     Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          colors: [
                              Color.fromARGB(255, 27, 26, 26),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            onPressed: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ),
          );
        },
         icon: const Icon(Icons.arrow_back))
         ),
         const Positioned(
          top: 0,
          left: 0,
          right: 60,
          bottom: 150,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 119,left: 20),
              child: Text('HIT:Endurance Training Basics | Salsol Training Club',
              style: TextStyle(color: Color.fromARGB(255, 251, 250, 250)),),
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 20,
            right: 200,
            bottom: 20,
           child: Row(
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
            SizedBox(width: 8),
            Text(
              '11 mins - Beginner',
              style: TextStyle(
                color: Colors.white),
            ),
          ],
        ),
       ),
       const Positioned(
            top: 170,
            left: 20,
            right: 0,
            bottom: 20,
           child: Row(
              children: [
                Icon(
                  Icons.accessibility_new,
                  color: Colors.white,
                ),
            SizedBox(width: 8),
            Text(
              '100% conditioning, Overall Fitness,Endurance',
              style: TextStyle(
                color: Colors.white),
            ),
          ],
        ),
       ),
        const Positioned(
            top: 280,
            left: 20,
            right: 140,
            bottom: 20,
           child: Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
            SizedBox(width: 8),
            Text(
              'None(Mat optional)',
              style: TextStyle(
                color: Colors.white),
            ),
          ],
        ),
       ),
        const Positioned(
            top: 450,
            left: 10,
            right: 0,
            bottom: 20,
           child: Row(
              children: [
             SizedBox(width: 10,),
            Text("You don't have to sweat for an hour to improve your endurance.\nEven this 10-minute session will get your heart rate cruising \nand kick your cardio fitness into high gear.",
              style: TextStyle(
                color: Colors.white),
            ),
          ],
        ),
       ),
        Positioned(
            left: 16,
            right: 0,
            bottom: 60,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                builder: (context) => YoutubePlayerScreen(
                videoId:videoId
                 ),
                )
              );
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(38),)
          ),
           child: const Text('Start Workout',
           style: TextStyle(color: Colors.black),)
           ),
          ),
      ],
    ),
   );
  }
}