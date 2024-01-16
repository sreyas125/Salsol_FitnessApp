import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/admin/Add_video.dart';
import 'package:salsol_fitness/Screens/admin/Edit_Guidance.dart';
import 'package:salsol_fitness/Screens/admin/Edit_workout.dart';
import 'package:salsol_fitness/Screens/admin/User_Details.dart';
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
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){ 
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const AdminLogin(),));
        }, icon: const Icon(Icons.arrow_back_outlined),color: Colors.black,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditWorkout()));
              break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVideoScreen()));
              break;
              case 4:
               Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGuidance(),));
               break;
              case 5:
               _showLogoutDialog(context);
            }
          },
          child: ListTile(
            title: Text(adminTitles[index]),
            trailing: index!=5? const Icon(Icons.arrow_forward_ios_outlined): const Icon(Icons.exit_to_app_rounded,color: Colors.red,),
          ),
        );
      }, 
           
      separatorBuilder: (BuildContext context,int index){
        return const Divider(
          height: 34,
          color: Color.fromARGB(255, 0, 0, 0),
        );
      },
       itemCount: 6),
    );
  }
}