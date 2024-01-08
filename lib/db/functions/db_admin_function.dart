import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_admin_function.dart';

void loginAdmin() async{
  var adminsBox = await Hive.openBox<Admin>('admins');

  var loggedInAdmin = Admin(name: 'sreyas',email: 'sreyasps125@gmail.com',id: 125);
  await adminsBox.put('loggedInAdminKey', loggedInAdmin);
}

Future<void> deleteLoggedInAdmin() async{
  var adminBox = await Hive.openBox<Admin>('admins');
  await adminBox.delete('loggedInAdminKey');
}