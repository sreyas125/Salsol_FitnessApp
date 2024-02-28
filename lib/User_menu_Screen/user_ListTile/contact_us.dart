// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  // Function to launch the Twitter link
  Future<void> _launchTwitter() async {
    const url = 'https://twitter.com/Sreyas_kurup_';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Contact Us'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border:Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: _launchTwitter,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: Colors.black,
                    size: 36,
                    weight: 50,
                  ),
                ),
                Text(
                  'Follow us on Twitter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Make the text blue
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
