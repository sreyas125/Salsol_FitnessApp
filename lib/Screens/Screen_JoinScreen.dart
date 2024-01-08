import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/Screen_SignIn.dart';
import 'package:salsol_fitness/Screens/login_screen.dart';
import 'package:salsol_fitness/db/functions/db_function.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';
import 'package:salsol_fitness/widgets/join_widgetrefactoring.dart';
import'package:intl/intl.dart';
class JoinScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const JoinScreen({Key? key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  late Box userid;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool agreed = false;
   bool agree = false;
   String selectedDate='';

   
  
     Future<void> selectDate(BuildContext context) async { 
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      dateofbirthcontroller.text = selectedDate;
      });
    }
  }
   bool _containsUppercase(String value){
    return value.contains(RegExp(r'[A-Z]'));
   }
   bool _containsLowercase(String value){
    return value.contains(RegExp(r'[a-z]'));
   }
   bool _containsNumber(String value){
     return value.contains(RegExp(r'[0-9]'));
   }
   bool _isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value);
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController surnamecontroller = TextEditingController();
  @override
  void initState() {
userid = Hive.box('customer_db');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.only(right: screenSize.width * 0.85, top: 20),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ScreenLogin(),));
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
                   ),
                     Padding(
                     padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.03,
                      right: MediaQuery.of(context).size.width * 0.03,
                      ),
                     child: Row(
                     children: [
                      Expanded(
                        child:  
                      CustomTextFieldtwo(hintText: 'First Name',
                      controller: namecontroller ,
                      
                      validator: (value){
                        if(value == null || value.isEmpty){
                        return'please Enter your first name';
                        }
                        return null;
                        },
                        ),
                      ),
                       
                      Expanded(
                        child:
                         CustomTextFieldtwo(hintText: 'Surname',
                         controller: surnamecontroller,
                         validator: (value){
                          if(value == null || value.isEmpty){
                            return 'please Enter Your Surename';
                          }
                          return null;
                         },),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                     SizedBox(
                      width: MediaQuery.of(context).size.width * 0.94,
                       child: CustomTextFieldtwo(
                        hintText: 'Email',
                        controller: emailcontroller,
                         validator:(value) {
                           if(value==null||value.isEmpty){
                            return 'please Enter an email';
                           }else if(!_isValidEmail(value)){
                            return 'please enter a valid email';
                           }
                           return null;
                         },
                         
                        )),
                       SizedBox(
                         width: MediaQuery.of(context).size.width * 0.94,
                         child: CustomTextFieldtwo(
                          hintText: 'password',
                          controller: passwordcontroller,
                          validator: (value){
                             if(value==null||value.isEmpty){
                              return 'please enter the password';
                             }else if(value.length<8){
                              return 'Password must contain at least 8 Character';
                             }else if(!_containsUppercase(value)||!_containsLowercase(value)||!_containsNumber(value)){
                              return 'password must contain at least one Uppercase letter,\none Lowercase letter and one number';
                             }
                              return null;
                          },)),
                        Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.53,),
                        child: const Text('X minimum of 8 charcters',style: TextStyle(color: Colors.grey),),
                      ),
                        Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.26),
                        child: const Text('X uppercase,lowercase letters and one number',style: TextStyle(color: Colors.grey),),
                      ),
                       SizedBox(
                      width: MediaQuery.of(context).size.width * 0.94, 
                      child: CustomTextFieldtwo(boolValue: false,
                        hintText: 'Date Of Birth (MM/DD/YYYY)',
                      controller: dateofbirthcontroller,
                        validator: (value) {
                        if(value== null || value.isEmpty){
                          return 'please enter your Date of Birth';
                        }
                        return null;
                      },)),

                      ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 255, 255, 0.674),),),
                     onPressed: () {
                        selectDate(context);
                      }, child:const Text('select date',style: TextStyle(color: Colors.black),)),
                      Row(
                        children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: 
                              Checkbox(value: agreed, onChanged: (value){
                              setState(() {
                              agreed = value?? false;
                                });
                               }),
                            ),
                              Padding(
                              padding: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.04,),
                              child: const Text('Sign up for emails to get updates\n from salsol on prodcts,offers \nand your member benefits',
                              style: TextStyle(color: Color.fromARGB(255, 102, 98, 98),
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                              ),
                            ),
                         ],
                       ),
                        Row(
                          children: [
                             Padding(
                               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                               child: 
                               Checkbox(value: agree,
                               onChanged: (bool? value){
                               setState(() {
                               agree = value!;
                                });
                               }),
                              ),
                          Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025,),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Color.fromARGB(255, 102, 98, 98), fontWeight: FontWeight.w800, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: "I agree to salsol's  ",
                                  style: TextStyle(color: Colors.grey,
                                  fontWeight: FontWeight.w400,fontSize: 17)
                                ),
                                TextSpan(
                                  text: "privacy policy\n and terms of use",
                                  style: TextStyle(decoration: TextDecoration.underline)
                                ),
                              ],
                            ),
                          ),
                        )
                       ],
                      ),
                      SizedBox( height: MediaQuery.of(context).size.height * 0.075,),
                      SizedBox(
                       width: MediaQuery.of(context).size.width * 0.75, 
                       height: MediaQuery.of(context).size.height * 0.0625,
                        child: ElevatedButton(
                          onPressed: (){
                        if(_formKey.currentState?.validate()?? false){
                           
                          if(agreed){
                            final value = fitnessModel(
                            email: emailcontroller.text,
                             password: passwordcontroller.text,
                              name: namecontroller.text,
                               surName: surnamecontroller.text,
                               dateOfBirth:dateofbirthcontroller.text,
                                );
                                addcustomer(value,userid);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder:(context) => const SigninScreen(),));
                          } else{
                            showDialog(
                              context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Agreement Required'),
                                content: const Text('Please agree to the terms to proceed.'),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }        
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1)),backgroundColor: Colors.black,),
                             child: const Text('Create Account',
                             style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
             ),
          ),
         ),
      ),
     );
   }
 }
