
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/sign_in_model.dart';

ValueNotifier<List<fitnessModel>> fitnessNotifier = ValueNotifier([]);

Future<void> addcustomer(fitnessModel value,userid) async{
  final key = DateTime.now().millisecondsSinceEpoch.toString();
   value.id = key;
   await userid.put(key, value);
   fitnessNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member
  fitnessNotifier.notifyListeners();
}

Future<List<fitnessModel>>getAllCustomer() async{
  final userid =  Hive.box<fitnessModel>('customer_db');
  List<fitnessModel> allCustomers = [];

  for(var key in userid.keys){
    final value = userid.get(key) as fitnessModel;
    allCustomers.add(value);
  }
  return allCustomers;
}

 