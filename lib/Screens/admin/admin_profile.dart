// ignore_for_file: override_on_non_overriding_member
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/Screens/admin/home_admin.dart';
import 'package:salsol_fitness/models/db_admin_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {

  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Admin? loggedInAdmin;
  SharedPreferences? prefs;




  @override
void initState() {
  super.initState();
  initializePreferences();
  getLoggedInAdmin();
  saveUserData();
  
  _nameController.text = loggedInAdmin?.name ?? '';
  _emailController.text = loggedInAdmin?.email ?? '';
}


Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

    Future<void> getLoggedInAdmin() async{
      prefs = await SharedPreferences.getInstance();
      var adminsBox = await Hive.openBox<Admin>('admins');
      // ignore: non_constant_identifier_names
      final AdminKey = adminsBox.get('loggedInAdminKey');
       if(AdminKey != null){
      setState(() {
         loggedInAdmin = AdminKey;
      });
     }else{
      String name = prefs!.getString('email') ?? 'Unknown';
      String email = prefs!.getString('password')?? 'Unknown';

      loggedInAdmin = Admin(name: name, email: email, id: 125);
     }
   }
 Future<void> saveUserData() async{
await prefs?.setString('admin_name', loggedInAdmin?.name ?? '');
    await prefs?.setString('admin_email', loggedInAdmin?.email ?? '');
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AdministrationScreen(),));
        },
         icon: const Icon(Icons.arrow_back_rounded),color: Colors.black,),
        title: const Text(' Admin Profile',style:TextStyle(color: Colors.black),),
        elevation: 2,  
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [  
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: TextFormField(
                    controller: _nameController,
                    decoration: 
                       const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(),
                    )
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter email',
                      border: OutlineInputBorder()
                      ),
                   ),
                 ),
                
                const SizedBox(height: 20,),
              Column(
                children: [
                  Text('Name: ${loggedInAdmin?.name ??''}',
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  const SizedBox(height: 20,),
                  Text('email: ${loggedInAdmin?.email ?? ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      const SizedBox(height: 20,),
                  const Text('ID:admin125',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ],
              ),
              const SizedBox(height: 20,),
               ElevatedButton(
                onPressed: (){
                   setState(() {
                     loggedInAdmin?.name = _nameController.text;
                     loggedInAdmin?.email = _emailController.text;
                     saveUserData();
                   });
                 }, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}