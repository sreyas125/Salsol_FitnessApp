import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/widgets/youtube_video_refactoring.dart';

class VideoScreenOne extends StatefulWidget {
  final Addvideomodel addvideomodel;

  const VideoScreenOne({Key? key, required this.addvideomodel}) : super(key: key);

  @override
  State<VideoScreenOne> createState() => _VideoScreenOneState();
}

class _VideoScreenOneState extends State<VideoScreenOne> {
  final String videoLink = 'UNa7kaCWCLs';

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
                      Image.asset(
                        'lib/Assets/hq720.webp',
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                            style: TextStyle(
                              color: Color.fromARGB(255, 251, 250, 250),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10),
                              child: const Icon(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10),
                              child: Icon(
                                Icons.accessibility_new,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Core Strength,Endurance,Glute Strength',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10),
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
              child: WorkoutDetailsScreen(
                videoLink: videoLink,
                defaultvideourl: widget.addvideomodel.videoUrl,
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
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
