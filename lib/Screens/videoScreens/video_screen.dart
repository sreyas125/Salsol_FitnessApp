// ignore_for_file: unnecessary_null_comparison, unnecessary_string_interpolations, use_super_parameters

import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/youtube/video_player.dart';

class VideoScreenOne extends StatefulWidget {
  final Addvideomodel addvideomodel;

  const VideoScreenOne({Key? key, required this.addvideomodel}) : super(key: key);

  @override
  State<VideoScreenOne> createState() => _VideoScreenOneState();
}

class _VideoScreenOneState extends State<VideoScreenOne> {
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: halfScreenHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      widget.addvideomodel.imageBytes != null?
                      Image.memory(
                        widget.addvideomodel.imageBytes,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                      :const Placeholder(),
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
                SizedBox(
                  height: screenHeight - halfScreenHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40,left: 20),
                          child: Text(
                            '${widget.addvideomodel.title}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 251, 250, 250),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10,left: 10),
                              child: Text(
                                '${widget.addvideomodel.time}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Icon(
                                Icons.accessibility_new,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.addvideomodel.selectedCategory,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10,bottom: 10),
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'None (Mat optional)',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.addvideomodel.discription,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 0,
              bottom: 60,
              child: ElevatedButton(
            onPressed: (){
              print('Video URL: ${widget.addvideomodel.videoUrl}');
           Navigator.push(
            context,
             MaterialPageRoute(
              builder: (context) => YoutubePlayerScreen(
                videoModel: widget.addvideomodel),
                ),
              );
            },
          style: ElevatedButton.styleFrom(
            
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 42),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38),)
          ),
           child: const Text('Start Workout',
           style: TextStyle(color: Colors.black),
        ),
      )
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScreenHome(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
