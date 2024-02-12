
import 'package:flutter/material.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubePlayerScreen extends StatefulWidget {
  // final String videoUrl;
  final Addvideomodel videoModel;
  // ignore: use_key_in_widget_constructors
  const YoutubePlayerScreen({Key? key,required this.videoModel});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _playerController;
  bool _isPlayerReady = false;
 
 bool isValidYoutubeVideoId(String videoId) {
 RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]{11}$');
 return regExp.hasMatch(videoId);
}
     @override
    void initState(){
      super.initState();
      initializePlayer();
     
    }
  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }
   void initializePlayer(){
    final extractedVideoId = extractVideoId(widget.videoModel.videoUrl);
      if(isValidYoutubeVideoId(extractedVideoId)) {
        debugPrint('done');
    _playerController = YoutubePlayerController(
     initialVideoId: extractedVideoId, 
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
      controlsVisibleAtStart: true,
      showLiveFullscreenButton: true,
    ),
  )..addListener(() {
    if(_playerController.value.isReady){
      setState(() {
        _isPlayerReady = true;
      });
    }
  });
      }else{
        debugPrint('invalid youtube ID');
       }
     }

   String extractVideoId(String url) {
    RegExp regExp = RegExp(r'(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^"&?\/\n\s]{11})');
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: _buildYoutubePlayer(),
    );
  }
   Widget _buildYoutubePlayer() {
     return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _playerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.black,
        onReady: () => debugPrint('Ready'),
        bottomActions: [  
          if(_isPlayerReady)...[
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.white,
              handleColor: Colors.white24,
            ),
          ),
          const PlaybackSpeedButton(),
        ],
      ]
    ),
       builder: (context,player){
          if(_playerController.value.isReady) {
             return player;
         }else{
      return  const Center(
        child: CircularProgressIndicator(
          color: Colors.red,),
          );
        }   
      },
    );
   }
}
