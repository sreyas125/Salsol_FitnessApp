// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:salsol_fitness/youtube/video_player.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final String videoLink;
  final String defaultvideourl;

  const WorkoutDetailsScreen({
    super.key,
    required this.videoLink,
    required this.defaultvideourl,
    });

    String extractVideoId(String url){
      RegExp regExp =RegExp(r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^"&?\/\n\s]{11})');
      Match? match = regExp.firstMatch(url);
      return match?.group(1) ?? '';
   }

  @override
  Widget build(BuildContext context) {
    String videoId = extractVideoId(videoLink.isEmpty?defaultvideourl:videoLink);
    return ElevatedButton(
            onPressed: (){                
               if( videoId.isNotEmpty){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => YoutubePlayerScreen(
                    videoId:videoId,
                  ),
                ),
              );
              }
            },
          style: ElevatedButton.styleFrom(
            
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 42),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38),)
          ),
           child: const Text('Start Workout',
           style: TextStyle(color: Colors.black),
        ),
      );
    
  }
}