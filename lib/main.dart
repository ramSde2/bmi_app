import 'package:app_demo/screens/splashscreen.dart';
import 'package:app_demo/screens/usercredential_screen.dart';
import 'package:app_demo/util/databaseHelper.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

main() async{

   WidgetsFlutterBinding.ensureInitialized();
   
 var database = await openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'userinfo.db'),
   onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
     'CREATE TABLE userinfotable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'height TEXT, '
        'weight TEXT, '
        'date TEXT)',
    );
   

  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
DatabaseHelper(database);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      
      routes: {
       '/':(context) =>  SplashScreen(),
        '/user':(context)=> UserScreen()
      },
      
     
     
    
    );
  }
}