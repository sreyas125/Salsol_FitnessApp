import 'package:flutter/material.dart';
import 'package:salsol_fitness/User_menu_Screen/user_settings.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserSettings(),));
        }, icon:const Icon(Icons.arrow_back)
        ),
      ),
      
    );
  }
}