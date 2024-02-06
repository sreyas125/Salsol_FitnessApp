import 'package:flutter/material.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class YogaScreen extends StatefulWidget {
  final List<Addvideomodel> videoSelectedList;
  const YogaScreen({super.key,required this.videoSelectedList});

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}