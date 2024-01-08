import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salsol_fitness/Screens/splash_screen.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_admin_function.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;

// ignore: constant_identifier_names
const SAVE_KEY_NAME = 'userLoggedIn';
Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AddvideomodelAdapter());

  Hive.registerAdapter(AdminAdapter());
  if(!Hive.isAdapterRegistered(fitnessModelAdapter().typeId)){
    Hive.registerAdapter(fitnessModelAdapter());
  }
  await Hive.openBox('customer_db');
  await Hive.openBox('images');
  await Hive.openBox<Addvideomodel>('videos');

    
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salsol Fitness',
      theme: ThemeData(
      
      ),
      home: const SplashScreen(),
    );
  }
}
