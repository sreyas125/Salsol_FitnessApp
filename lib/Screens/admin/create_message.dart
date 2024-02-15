import 'package:flutter/material.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/another_Page.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/local_notifications.dart';

class CreateMeessage extends StatefulWidget {
  const CreateMeessage({super.key});

  @override
  State<CreateMeessage> createState() => _CreateMeessageState();
}

class _CreateMeessageState extends State<CreateMeessage> {
  final TextEditingController _notificationtitlecontroller =
      TextEditingController();
  final TextEditingController _notificationbodycontroller =
      TextEditingController();
  final TextEditingController _notificationpayloadcontroller =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    listenToNotifications();
  }

  listenToNotifications() {
    print('Listening to notification');
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnotherPage(payload: event)),
      );
    });
  }

  Future<void> _showConfirmationDialog() async {
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text('Notifications Not Enabled'),
      //       content: const Text(
      //           'You have not enabled notifications. Please enable notifications to receive messages.'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Are you sure you want to send this message?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                LocalNotifications.showSimpleNotification(
                  title: _notificationtitlecontroller.text.toString(),
                  body: _notificationbodycontroller.text.toString(),
                  payload: _notificationpayloadcontroller.text.toString(),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Message'),
        backgroundColor: Colors.white10,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _notificationtitlecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Notification title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _notificationbodycontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Notification Body',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _notificationpayloadcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Notification payload',
              ),
            ),
          ),
          ElevatedButton.icon(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.black54,
              ),
            ),
            onPressed: _showConfirmationDialog,
            icon: const Icon(Icons.timer_outlined),
            label: const Text('Simple Notification'),
          ),
          TextButton(
            onPressed: () {
              LocalNotifications.cancelAll();
            },
            child: const Text(
              'Cancel All Notifications',
              style: TextStyle(color: Colors.black38),
            ),
          )
        ],
      ),
    );
  }
}
