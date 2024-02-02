import 'package:app_demo/screens/splashscreen.dart';
import 'package:app_demo/screens/userscreen.dart';

import 'package:flutter/material.dart';

void main() {
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