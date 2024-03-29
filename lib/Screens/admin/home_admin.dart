import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/admin/add_video.dart';
import 'package:salsol_fitness/Screens/admin/add_Guidance.dart';
import 'package:salsol_fitness/Screens/admin/Edit_Guidance.dart';
import 'package:salsol_fitness/Screens/admin/create_message.dart';
import 'package:salsol_fitness/Screens/admin/edit_workout.dart';
import 'package:salsol_fitness/Screens/admin/user_Details.dart';
import 'package:salsol_fitness/Screens/admin/admin_login.dart';
import 'package:salsol_fitness/Screens/admin/admin_profile.dart';




class AdministrationScreen extends StatefulWidget {

   const AdministrationScreen({super.key});

  @override
  State<AdministrationScreen> createState() => _AdministrationScreenState();
}

class _AdministrationScreenState extends State<AdministrationScreen> {

     Future<void> _showLogoutDialog(BuildContext context) async {
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AdminLogin(),
                  ), (route) => false);
            },
          ),
        ],
      );
    },
 );
}

  final List<String> adminTitles = [
    'User Details',
    'Edit Workouts',
    'Add Video',
    'Create Message',
    'Add Guidance',
    'Edit Guidance',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(),
          title: const Text('Administration',
          style: TextStyle(color: Colors.black),),
          actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AdminProfile(),));
            },
           icon: const Icon(Icons.person_pin,
           color: Colors.lightBlue,)),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context,int index){
        return InkWell(
          onTap: (){
            switch(index){
              case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDetails()));
              break;
              case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const EditWorkout()));
              break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddVideoScreen(greatForHomeVideos: [],)));
              break;
              case 3:
               Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMeessage(),));
              case 4:
               Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGuidance(),));
               break;
               case 5:
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  const EditGuidance(),));
                break;
              case 6:
               _showLogoutDialog(context);
            }
          },
          child: ListTile(
            title: Text(adminTitles[index]),
            trailing: index!=6? const Icon(Icons.arrow_forward_ios_outlined): const Icon(Icons.exit_to_app_rounded,color: Colors.red,),
          ),
        );
      }, 
           
      separatorBuilder: (BuildContext context,int index){
        return const Divider(
          height: 34,
          color: Color.fromARGB(255, 0, 0, 0),
        );
      },
       itemCount: 7),
    );
  }
}