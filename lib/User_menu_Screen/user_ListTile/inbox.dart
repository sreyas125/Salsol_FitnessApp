// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/models/test.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<NotificationItems> inboxvideos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async{
    final box =  Hive.box<NotificationItems>('notifications');
    setState(() {
      inboxvideos = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: inboxvideos.length,
                itemBuilder: (BuildContext context, int index) {
                  final inboxvideo = inboxvideos[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(inboxvideo.notifications ?? ''),
                        subtitle: Text(inboxvideo.notificationbody ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ScreenHome()),
                          );
                        },
                      ),
                      if (index != inboxvideos.length - 1) const Divider(thickness: 1), 
                    ],
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}