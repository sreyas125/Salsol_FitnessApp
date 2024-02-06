import 'package:flutter/material.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/user_edit.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
void showLogoutSnackBar(BuildContext context) {

Future<void> signOutUser() async {
 final sharedprefs = await SharedPreferences.getInstance();
 await sharedprefs.setBool(SAVE_KEY_NAME, false);
}

  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Are You Sure You Want to Log Out?'),
      actions: [
        TextButton(onPressed: () async{
          await signOutUser();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ScreenLogin(),), (route) => false);
        }, 
        child: const Text('LogOut',style: TextStyle(color: Colors.red),)
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const ScreenHome() ,));
        }, icon:const Icon(Icons.arrow_back_rounded)),
        title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent.withOpacity(0.3),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return  ListTile(
                title: Text('User Edit'),
                onTap: () {
                  String userEmail = 'user@example.com';
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserEditScreen(userEmail: userEmail,),));
                },
              );
            case 1:
              return const ListTile(
                title: Text('About You'),
              );
            case 2:
              return const ListTile(
                title: Text('Privacy'),
              );
            case 3:
              return const ListTile(
                title: Text('Contact Us'),
              );
            case 4:
              return const ListTile(
                title: Text('Delete Account'),
              );
             case 5:
              return ListTile(
                title: const Text('Log Out',
                style: TextStyle(color: Colors.red),),
                trailing: const Icon(Icons.logout_outlined,
                color: Colors.red
                ),
                onTap: () {    
                  showLogoutSnackBar(context);    
             },
            );
          }
          return null;
        },
      ),
    );
  }
}