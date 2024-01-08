import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late String Savekeyname = 'userLoggedIn';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        'lib/Assets/initial_simple_brand_logo.mp4')
      ..initialize().then((value) {
        setState(() {});
        _controller.play();
      });

    Future.delayed(const Duration(seconds: 2), () {
      checkUserLoggedIn();
    });
  }

  Future<void> checkUserLoggedIn() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(SAVE_KEY_NAME,);

    await Future.delayed(const Duration(seconds: 2));

    if (userLoggedIn == null || !userLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const ScreenHome()));
    }
  }
@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
       child: _controller.value.isInitialized
           ? AspectRatio(
               aspectRatio: _controller.value.aspectRatio,
               child: FittedBox(
                   fit: BoxFit.contain,
                 child: SizedBox(
                     height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                     child: Container(
                      color: const Color.fromARGB(255, 36, 36, 36),
                      child: VideoPlayer(_controller))),
               ),
             )
           : const Center(
               child: CircularProgressIndicator(),
             )
          ),
      );
   }
}     