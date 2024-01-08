
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;
  // ignore: use_key_in_widget_constructors
  const YoutubePlayerScreen({Key? key,required this.videoId});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _playerController;
 
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
      if(isValidYoutubeVideoId(widget.videoId)) {
    _playerController = YoutubePlayerController(
     initialVideoId: widget.videoId,
    // _extractVideoId(widget.videoId), 
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
      controlsVisibleAtStart: true,
      showLiveFullscreenButton: true,
      
    ),
  );
      }else{
        debugPrint('invalid youtube id..........');
       }
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: _buildYoutubePlayer(),
    );
  }
   Widget _buildYoutubePlayer() {
    if(isValidYoutubeVideoId(widget.videoId)) {
     return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _playerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.black,
        onReady: () => debugPrint('Ready'),
        bottomActions: [      
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
      ),
       builder: (context,player){
        return player;
      },
    );
    }else{
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
   }

  String _extractVideoId(String url) {
  RegExp regExp = RegExp(r'(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^"&?\/\n\s]{11})');
  Match? match = regExp.firstMatch(url);
  return match?.group(1) ?? '';
  }
}
