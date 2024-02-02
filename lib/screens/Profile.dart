import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  var username;
   var gender;
  var height;
  var weight;
   ProfilePage({
    required this.username,
    required this.gender,
    required this.height,
    required this.weight
   });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}