import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/admin/edit_workout.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/User%20Profile.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {


  Future<void> _showLogoutDialogs(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout',style: TextStyle(color: Colors.red,),),
                content: const Text('Are you sure you want to logout?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel',style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
          TextButton(
            child: const Text('Logout',style: TextStyle(color: Colors.red),),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>const ScreenLogin(),), (route) => false);
            },
          ),
        ],
      );
    },
 );
}

  final List<String> items= [
   'User Edit',
   'About You',
   'Privacy',
   'Language',
   'Contact Us',
   'Delete Account',
   'Log Out',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenHome(),));
        }, icon: const Icon(Icons.arrow_back)),
        title: const Text('Settings',
        style: TextStyle(
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      body:Column(
 children: [
    Expanded(
      flex: 5,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                 Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Userprofile(),));
                 break;
                case 1:
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditWorkout(),));
                case 6:
                  _showLogoutDialogs(context);
                break;       
              }
              
            },
             child: ListTile(
               title: Text(items[index]),
               trailing: index == 6? const Icon(Icons.exit_to_app_rounded,color: Colors.red,):null,
             ),
          );
        },
      ),
    ),
 ],
),
    );
  }
}