
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
    final extractedVideoId = YoutubePlayer.convertUrlToId(
      widget.videoModel.videoUrl
      );
     if(extractedVideoId != null){
    _playerController = YoutubePlayerController(
     initialVideoId: extractedVideoId, 
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
      controlsVisibleAtStart: true,
      showLiveFullscreenButton: true,
      
    ),
  )..addListener(() {
    setState(() {
      _isPlayerReady = true;
    });
    });
   }
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     body: Center(
      child: _buildYoutubePlayer()),
    );
  }
   Widget _buildYoutubePlayer() {
     return YoutubePlayerBuilder(
      player: YoutubePlayer(

        controller: _playerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.white,
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
          IconButton(
            
            onPressed: (){
            _playerController.toggleFullScreenMode();
          }, icon: Icon(
            _playerController.value.isFullScreen
          ?Icons.fullscreen_exit
          :Icons.fullscreen)),
          const PlaybackSpeedButton(),
        ],
      ]
    ),
       builder: (context,player){
         return player;
      },
    );
   }
}
