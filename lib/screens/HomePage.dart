

import 'package:app_demo/screens/Profile.dart';
import 'package:app_demo/widget/barchart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
   var username;
   var gender;
  var height;
  var weight;
  HomePage({required this.height,required
    this.weight,required this.gender,required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bmi formula
  //[weight (kg) / height (cm) / height (cm)] x 10,000
 
  @override
  Widget build(BuildContext context) {

    // String  bmi= ((widget.weight)/(widget.height*widget.height)*10000);
      double weight=double.parse((widget.weight));
        double height=double.parse((widget.height));
     double bmi= weight / ((height / 100) * (height / 100));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: false,
        
        title: Text("Hello ${widget.username}",style: TextStyle(color: Colors.black,fontSize: 24),),
        automaticallyImplyLeading: false,
        actions: [IconButton( icon: Icon(Icons.person_2), onPressed: () { 
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfilePage(gender: widget.gender,height: widget.height,weight: widget.weight,username: widget.username,)));
           },
           ),
           
           ]
           ),
        body: Padding(
          padding: const EdgeInsets.only(top:28.0,left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
         const  Text("BMI",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromARGB(165, 29, 27, 27)),),
       const Gap(8),
       Text(bmi.toStringAsFixed(2),style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),

       const Gap(14),

       BarGraph(),
       









          
          
          ]),
        ),   

    );
  }
}