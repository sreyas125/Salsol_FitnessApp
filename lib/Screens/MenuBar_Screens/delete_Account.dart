import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/MenuBar_Screens/settings.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings(),));
        }, icon: const Icon(Icons.arrow_back_outlined)),
        title: const Text('Delete Account'),
      ),
      body: const Column(
        children: [
          Text('Are You Sure You Want to Delete Your Account?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}