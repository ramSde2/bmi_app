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
  String isset = '';

  Future<void> get_stored_pref() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      isset =  pref.getString('isset') ?? '';
      gender =   pref.getString('gender') ?? '';
      name =  pref.getString('username') ?? '';
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    get_stored_pref();
    print(isset);
    print(name);
    print(gender);

    Future.delayed(
      Duration(seconds: 3),
      () {
        if (isset.isNotEmpty) {
          // if (isset == "true") {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomePage(gender: gender, username: name),
          //     ),
          //   );
          // } else {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => UserScreen(),
        //       ),
        //     );
        //   }
        // } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserScreen(),
            ),
          );
        }
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
