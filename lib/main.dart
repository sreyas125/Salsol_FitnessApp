import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salsol_fitness/Screens/splash_screen.dart';
import 'package:salsol_fitness/User_menu_Screen/user_ListTile/local_notifications.dart';
import 'package:salsol_fitness/models/db_Guidance_add_function.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';
import 'package:salsol_fitness/models/db_admin_function.dart';
import 'package:salsol_fitness/models/db_saved_workout.dart';
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
  Hive.registerAdapter(GuidanceAdapter());
  if(!Hive.isAdapterRegistered(fitnessModelAdapter().typeId)){
    Hive.registerAdapter(fitnessModelAdapter());
  }
  if(!Hive.isAdapterRegistered(SavedWorkoutAdapter().typeId)){
    Hive.registerAdapter(SavedWorkoutAdapter());
  }
  await Hive.openBox<fitnessModel>('customer_db');
  await Hive.openBox('images');
  await Hive.openBox<Addvideomodel>('videos');
  await Hive.openBox<Guidance>('Guidance');
  await Hive.openBox<Guidance>('Guidanceimages');
  await LocalNotifications.init();
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
