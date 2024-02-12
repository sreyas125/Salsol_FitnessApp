import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/User_menu_Screen/user_settings.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';

class UserEditScreen extends StatefulWidget {
  final Future<fitnessModel> userModelFuture;
  const UserEditScreen({super.key,
  required this.userModelFuture,});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController _newEmailController;
  late TextEditingController _confirmEmailcontroller;
  String? _currentEmail; 

  @override
  void initState() {
    super.initState();
    _newEmailController = TextEditingController();
    _confirmEmailcontroller = TextEditingController();
    loadcustomer();
  }
  Future<void> loadcustomer() async{
   final userModel = await widget.userModelFuture;
   setState(() {
     _currentEmail = userModel.email;
     _newEmailController.text = _currentEmail ?? '';
   });
  }
     Future<void> _saveChanges() async{
      final newEmail = _newEmailController.text;
      final confirmEmail = _confirmEmailcontroller.text;

      if(newEmail == confirmEmail){
        final userModel = await widget.userModelFuture;
      userModel.email = newEmail;

      final box = await Hive.openBox<fitnessModel>('customer_db');
      final index = await box.add(userModel);
      print('updated usermodel at index $index');

      if(box.isNotEmpty){
        final previousIndex = box.keys.first;
        box.delete(previousIndex);
        print('previous email removed $previousIndex');
      }

      setState(() {
        _currentEmail = newEmail;
        _newEmailController.text = '';
        _confirmEmailcontroller.text = '';
        
      });
      }else{
        showDialog(
         context: context,
         builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('New Email and confirm email do not match.'),
          actions: [
            TextButton(onPressed: ()=> Navigator.pop(context),
             child: Text('Ok'),)
           ],
         )
       );
     }  
   }

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Edit'),
        backgroundColor: Colors.grey,
        leading: BackButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => UserSettings(),));
            },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 90,left: 75),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                    text: "Your current account email Address is:\n",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: _currentEmail ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        )
                      )
                    ]
                  ),
                )
              ),
            ),
          ],
        ),
       const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _newEmailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'New Email',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
        ),
          const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                        controller: _confirmEmailcontroller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                hintText: 'Confirm Email',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
           ),
          const SizedBox(height: 30,),
           ElevatedButton(
              onPressed:_saveChanges,   
             style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.grey),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.33, vertical: 15),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                      ),
                   ),
               ),
           ),
      ],
    ),
  );
 }
}