import 'package:flutter/material.dart';

class MuscleGroupScreen extends StatefulWidget {

  const MuscleGroupScreen({super.key,});

  @override
  State<MuscleGroupScreen> createState() => MuscleGroupScreenState();
}

class MuscleGroupScreenState extends State<MuscleGroupScreen> {
   late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Colors.grey,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Abs & Core',),
              Tab(text: 'Arms & SHoulders',),

            ]
            ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                Text('Abs& Core'),
              ],
            )
          ]),
      ),
    );
  }
}