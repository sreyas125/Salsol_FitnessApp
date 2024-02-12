import 'package:flutter/material.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About You'),
        backgroundColor: Colors.white10,
        leading: BackButton(),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Expanded(
              child: Text("we'd like this information to provide more accurate results,\nsuch as run distance,pace and calories.For coaching plans,this information,in addition to your age,helps personalize ypur plan to be right for you.")),
          )
        ],
      ),
    );
  }
}