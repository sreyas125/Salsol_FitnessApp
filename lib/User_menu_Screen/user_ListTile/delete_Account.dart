// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool agreed = false;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color buttonColor = agreed ? Colors.black : const Color.fromARGB(255, 180, 178, 178);
    Color textColor = agreed ? Colors.white : const Color.fromARGB(255, 112, 108, 108);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Delete Account'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Text(
              'Are You Sure You Want to Delete Your Account?',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 52, 51, 51)),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'If you delete your account:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(CupertinoIcons.link),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  '''You'll lose all data in associated salsol app accounts using the same email address and phone number.''',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(CupertinoIcons.person_2),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "You won't be able to access salsol member benefits",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.phone_android_outlined),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "You'll be disconnected from salsol fitness app.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Once you delete your account, you'll be logged out of this app. If you're logged into this salsol app, it could take up to 1 hour for your session to expire.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'If you change your mind, you can always come back and open a new account with us.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Are you sure you want to delete your account? (This can't be undone)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Checkbox(
                    activeColor: Colors.black,
                    value: agreed,
                    onChanged: (value) {
                      setState(() {
                        agreed = value!;
                        if (agreed) {
                          buttonColor = Colors.black;
                          textColor = Colors.white;
                        }else{
                        buttonColor = const Color.fromARGB(255, 180, 178, 178);
                        textColor = const Color.fromARGB(255, 112, 108, 108);
                        }
                      });
                    },
                  );
                },
              ),
             const  Text(
                'Yes, I want to delete my account.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color:Color.fromARGB(255, 73, 71, 71),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: agreed
                ? () {
                      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Are you sure you want to delete this account?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); 
                              },
                              child: const Text("Cancel",style: TextStyle(color: Colors.black),),
                            ),
                            TextButton(
                              onPressed: () async {
                                final userIdBox = Hive.box<fitnessModel>('customer_db');
                                userIdBox.clear();
                                final prefs = await SharedPreferences.getInstance();
                                prefs.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ScreenLogin(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text("Delete Account",style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        );
                      },
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: buttonColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.25, vertical: 18),
              child: Text(
                'Delete Account',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
           const SizedBox(height: 20,),
          ElevatedButton(
            onPressed:(){
             Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black,width: 0.4,),
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.33, vertical: 18),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 45, 45),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
