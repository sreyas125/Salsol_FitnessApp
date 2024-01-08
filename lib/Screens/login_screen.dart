import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/Screen_SignIn.dart';
import 'package:salsol_fitness/Screens/Screen_JoinScreen.dart';
import 'package:salsol_fitness/Screens/admin/admin_login.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
  //  getAllCustomer();
    return SafeArea(
      child: Scaffold(
         body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/Assets/Squat_jumps.jpeg',
              fit: BoxFit.cover,
              colorBlendMode: 
              BlendMode.srcOver,
              color: Colors.black.withOpacity(0.5),
            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Padding(
                  padding: EdgeInsets.only(
                    right: screenSize.width * 0.1,
                    bottom: screenSize.height * 0.02,
                    ),
                  child: const Text('SalSol Training Club',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                   ),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.only(
                    bottom: screenSize.height * 0.05,
                    right: screenSize.width * 0.05,
                    ),
                  child: const Text('Your space for wellness,your way \n move with us',
                  style: TextStyle(color: Color.fromARGB(255, 208, 205, 205),fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.17),
                  child: Row(
                    children: [
                      ElevatedButton(onPressed: (){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SigninScreen() ,));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                           backgroundColor: Colors.white,
                         ), child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                            vertical: screenSize.height * 0.015,),
                          child: const Text('Sign In',style: TextStyle(color: Colors.black),),
                      ),
                        ),
                         Padding(
                           padding: const EdgeInsets.only(left: 50),
                           child: ElevatedButton(
                              onPressed: (){
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const JoinScreen(),));
                                                   },
                                style: ElevatedButton.styleFrom(                              
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                        backgroundColor:Colors.white 
                                               ), 
                                          child: Padding(
                                          padding: EdgeInsets.symmetric(
                                         horizontal: screenSize.width * 0.05,
                                         vertical: screenSize.height * 0.015,),
                                         child: const Text(
                                      'Join Us',
                                   style: TextStyle(color: Colors.black),
                          ),
                         ),
                       ), 
                    ),
                  ],
                 ),
               ),
               Row(
                children: [
                   Padding(
                  padding:  EdgeInsets.only(
                     left: screenSize.width * 0.37,
                    bottom: screenSize.height * 0.11,
                    top: screenSize.height * 0.04,
                    ),
                  child: Row(
                    children: [
                      ElevatedButton(onPressed: (){
                       Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const AdminLogin(),));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                           backgroundColor: const Color.fromARGB(255, 107, 103, 103),
                         ), child: Padding(
                        padding: EdgeInsets.symmetric(
                           horizontal: screenSize.width * 0.05,
                           vertical: screenSize.height * 0.015,),
                        child: const Text('Admin',style: TextStyle(color: Color.fromARGB(255, 213, 209, 209)),),
                         ),
                       ),
                     ],
                   ),
                ),
                ],
               )
              ],
            ),
          ]
        ),
      ),
    );
  }
}