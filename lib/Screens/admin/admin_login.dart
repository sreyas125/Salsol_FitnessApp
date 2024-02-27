import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/admin/home_admin.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
     bool isValidEmail(String email){
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(email);
     }
     bool agree = false;
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

     void _validateAndSave() async{
      final form = _formkey.currentState;
      if(form?.validate()?? false){
        form?.save();
        if(isValidCredentials(emailcontroller.text, passwordcontroller.text)&& agree){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', emailcontroller.text);
          await prefs.setString('password', passwordcontroller.text);
          

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdministrationScreen(),));
       
        }else{
          if(!isValidCredentials(emailcontroller.text, passwordcontroller.text)){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('invalid Email and password'),
                content: const Text('You Entered Email and Password is incorrect please Try Again'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('OK')),
                ],
              );
            });
          }else if(!agree){
            ScaffoldMessenger.of(context).showSnackBar 
            (const SnackBar(
              backgroundColor: Colors.red,    
              content:
             Text('Please agree to the terms to continue,')));
          }
        }
      }
     }
  bool isValidCredentials(String email,String password){
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email) && password == 'admin125';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScreenLogin(),), (route) => false);
        }, icon: const Icon(Icons.arrow_back),color: Colors.black),
        backgroundColor: Colors.grey,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              'Admin Login',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('lib/Assets/Modern Stripe Stock Exchange Company Logo (1).png'),
               const SizedBox (height: 20,),
              Container(
                padding:const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: TextFormField(
                        controller: emailcontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value==null|| value.isEmpty){
                             return 'Admin must Enter your Email ID';
                          }else if(!isValidEmail(value)){
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 223, 223, 223)),
                         ),
                        ),
                      ),
                    ),  
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordcontroller,
                        obscureText: true,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                             return 'you must Enter your password';
                          }else if(value!='admin125'){
                             return 'incorrect password please check your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                         hintText: 'Password',
                         hintStyle: const TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.black),
                         ),
                        ),
                      ),
                    ),
                   const SizedBox(height: 15,),
                      Row(
                        children: [
                          Checkbox(value: agree, onChanged: (value){
                                    setState(() {
                                    agree = value!;
                                      });
                                     }),
                         const Text("By continuing,Admin Must\nFollow the salsol's Privacy policy\nand terms of use",
                         style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                        ],
                      ),
                     const SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: 
                          _validateAndSave,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                            backgroundColor: Colors.black),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 110,vertical: 20),
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
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