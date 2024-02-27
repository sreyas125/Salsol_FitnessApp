// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  final String payload;
  const AnotherPage({super.key,required this.payload});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another page demo'),
      ),
      body:Center(child: Text(payload)),
    );
  }
}