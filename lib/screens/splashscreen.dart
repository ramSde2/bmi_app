import 'package:app_demo/screens/HomePage.dart';
import 'package:app_demo/screens/usercredential_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String name = '';
  String gender = '';
  bool isProfileSet = false;

  Future getUserInfo()async{
    SharedPreferences preferce = await SharedPreferences.getInstance();
    isProfileSet = preferce.getBool("isProfileSet") ?? false;
    // name=preferce.getString("name")!;
    // gender=preferce.getString("gender")!;
    print(name);
    print(gender);
  }

  @override
  void initState() {
    super.initState();
   getUserInfo();
   

    Future.delayed(
      Duration(seconds: 3),
      () {
       
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => isProfileSet ? HomePage(username: name,gender: gender,):UserScreen(),
            ),
          );
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          color: Colors.white,
        ),
        child: Container(
          height: 240,
          width: 240,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(image: AssetImage('assets/images/bmi.png')),
          ),
        ),
      ),
    );
  }
}
