// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/For_You/for_you.dart';
import 'package:salsol_fitness/Screens/Guidance/guidance.dart';
import 'package:salsol_fitness/Screens/MenuBar_Screens/saved_workouts.dart';
import 'package:salsol_fitness/Screens/browse/browseList.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/inbox.dart';
import 'package:salsol_fitness/User_menu_Screen/user_settings.dart';



class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with SingleTickerProviderStateMixin {
  bool isBookmarked = false;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3,vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//  Future<void> checkNotificationsEnabled() async{
//   bool enabled = true;
//   if(enabled){
//     await showDialog(
//       context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//         title:const Text('Enable Notifications?'),
//         content: const Text('Do you want to enable notifications?'),
//         actions: [
//           TextButton(onPressed: (){
//             setState(() {
//               areNotificationEnabled = true;
//             });
//             Navigator.of(context).pop();
//           }, child:const Text('Enable'),
//          ),
//          TextButton(onPressed: (){
//           setState(() {
//             areNotificationEnabled = false;
//           });
//           Navigator.of(context).pop();
//          }, child: const Text('Don\'t Allow'),
//          )
//         ],
//        );
//      });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu_outlined),
          color: Colors.black,
        ),
        title: const Text(
          'WorkOuts',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Browse'),
            Tab(text: 'Guidance'),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 250, 250)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle,
                    size: 60,
                    color: Colors.blueAccent,),
                    SizedBox(height: 10,),
                    Text('Username',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.timer, color: Colors.black),
                title: const Text('Workouts'),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ScreenHome(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.black),
                title: const Text('Saved Workouts'),
                onTap: () {
               Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  const SavedWorkouts(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.inbox_outlined, color: Colors.black),
                title: const Text('Inbox'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InboxScreen(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const UserSettings(),));
                },
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Text(
                  'New Workouts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
               SizedBox(height: 20),
                    ForYou()
                  ]          
                ),
                WorkoutFocus(), 
               GuidanceTab(),
        ],
      ),
    );
  }
}
