import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/Screens/screen_home.dart';
import 'package:salsol_fitness/main.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';
import 'package:salsol_fitness/widgets/custom_password_text_field.dart';
import 'package:salsol_fitness/widgets/signin_widgetrefactoring.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}
class _SigninScreenState extends State<SigninScreen> {
  late Box userid;
   bool agreed = false;
   @override
  void initState() {
    userid = Hive.box<fitnessModel>('customer_db');
    super.initState();
  }
   
   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
   TextEditingController emailcontroller = TextEditingController();
   TextEditingController passwordcontroller = TextEditingController();
   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

   Future<void> _showDilog() async {
      return showDialog(
        context: context,
         builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Terms And Agreement Required'),
          content: const Text('Please Agree Our terms and conditions to proceed'),
        actions:<Widget> [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('OK'))
        ],
        );
      });
     }
  Future<void> _validateAndSave(String email, String password) async {
  final form = _formkey.currentState;
  if (form?.validate() ?? false) {
    form?.save();
    if (agreed == true) {
      bool credentialsMatch = await validateCredentials(email, password);
      if (credentialsMatch) {
        final sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.setBool(SAVE_KEY_NAME, true);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username and password doesn't match"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(20),
          ),
        );
      }
    } else {
      _showDilog();
    }
  }
}
   Future<bool> validateCredentials(String email, String password) async {
  final userBox = Hive.box<fitnessModel>('customer_db');
  for (var i = 0; i < userBox.length; i++) {
    final user = userBox.getAt(i);
    if (email == user?.email && password == user?.password) {
      return true; 
    }
  }
  return false; 
}

   bool isValidEmail(String email){
    return emailRegex.hasMatch(email);
   }

   
  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.88, top: 50),
                child: IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScreenLogin(),));
                }, 
                icon: const Icon(Icons.arrow_back)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: screenWidth * 0.57),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child:Image.asset('lib/Assets/Modern Stripe Stock Exchange Company Logo (1).png'),
                 ),
              ),
                Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20,left: screenWidth * 0.1),
                    child: const Text('Enter your email to',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
                Row(
                children: [
                   Padding(
                    padding: EdgeInsets.only(top: 10, left: screenWidth * 0.09),
                    child: const Text('Join us or sign in.',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
               Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.12, top: 10),
                    child: const Text('India'),
                  ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: screenWidth * 0.08),
                      child: const Text('Change',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2
                        ),
                      ),
                    ),
                ],
               ),
                 customTextField(
                  key: const ValueKey('email'),
                  texthint: 'Email',
                icon: Icons.email_outlined,
                 emailcontroller: emailcontroller,
                   validator: (value) {
                   if(value==null || value.isEmpty){
                    return 'please enter an email';
                   }else if(!isValidEmail(value)) {
                    return 'please enter a valid email';
                   }
                    return null;
                },),
                 Custompassword(
                  key: const ValueKey('password'),
                  texthint: 'Password',
                  controller: passwordcontroller,
               icon: Icons.remove_red_eye_outlined,
               validator: (value) {
                 if(value==null||value.isEmpty) {
                  return 'please enter an password';
                 }
                 return null;
               },),
        
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState){
                        return Checkbox(
                          value: agreed,
                         onChanged: (value){
                          setState(() {
                            agreed=value!;
                          });
                        });}
                      ),
                      const Text("By Continuing,I agree to salsol's \nprivacy policy and terms of use",
                      style: TextStyle(color: Color.fromARGB(255, 197, 195, 195),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed:(){
                          if(agreed){
                            _validateAndSave(emailcontroller.text,passwordcontroller.text);
                          } else{
                            _showDilog();
                          }
                        }, 
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                          backgroundColor: Colors.black),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.33, vertical: 20),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                          ),
                      ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
