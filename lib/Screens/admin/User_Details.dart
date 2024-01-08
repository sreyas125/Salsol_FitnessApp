import 'package:flutter/material.dart';
import 'package:salsol_fitness/Screens/admin/home_admin.dart';
import 'package:salsol_fitness/db/functions/db_function.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {  
  late List<fitnessModel>allCustomer = [];

  @override
   void initState(){
    super.initState();
     loadCustomer();
   }
  Future<void> loadCustomer() async {
    List<fitnessModel>customers = await getAllCustomer();
    setState(() {
      allCustomer = customers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.3),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdministrationScreen()));
        }, icon:const Icon(Icons.arrow_back_rounded)),
        title:const Text('User Details'),
      ),
      body: ListView.builder(
         itemCount: allCustomer.length,
        itemBuilder:(BuildContext context, index) {
        final customer = allCustomer[index];
        
        return ListTile(
         title: Text('Name : ${customer.name}'),
         subtitle: Text('Email : ${customer.email}'),
         trailing: Text('DOB : ${customer.dateOfBirth}'),
         );
       }
     ),
   );
  }
}