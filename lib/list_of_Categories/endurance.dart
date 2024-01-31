import 'package:flutter/material.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
class Endurance extends StatefulWidget {
  final List<Addvideomodel> VideoList;
  final List<String> selectedCategories;
   const Endurance( {super.key,
  required this.VideoList,
  required this.selectedCategories
  });

  factory Endurance.create({
    required List<Addvideomodel> categoryVideoList,
    required List<String> selectedCategories,
  }){
    return Endurance(
      key: UniqueKey(),
     VideoList: [],
       selectedCategories: selectedCategories
       );
  }

  @override
  State<Endurance> createState() => _EnduranceState();
}

class _EnduranceState extends State<Endurance> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildEnduranceTab(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.VideoList.length,
      itemBuilder: (context,index){
        final video = widget.VideoList[index];
        return ListTile(
          title: Text(video.title),
          subtitle: Text(video.discription),
        );
      }
    );
  }

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
              Tab(text: 'Endurance',),
              Tab(text: 'Yoga',),
            ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.VideoList.isEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.VideoList.length,
                    itemBuilder: (context,index){
                      final video = widget.VideoList[index];
                      return ListTile(
                        title: Text(video.title),
                        subtitle: Text(video.discription),
                      );
                    }) )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Yoga Page'),
                )
              ],
            )
          ]),
      ),
    );
  }
}