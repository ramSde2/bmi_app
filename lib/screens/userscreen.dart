import 'package:app_demo/screens/HomePage.dart';
import 'package:app_demo/widget/selectgender.dart';
import 'package:app_demo/widget/userinput.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var nameController = TextEditingController();
 
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
     heightController.dispose();
      weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedgender=0;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(
           decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 0.6, 0.9],
            colors: [
              Colors.yellow,
              Colors.red,
              Colors.indigo,
              Colors.teal,
            ],
          ),
        ),
          
          
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: 
         SizedBox(
                height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,


           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 UserInput(
                   datatype: "Name",
                   keyboardType: TextInputType.name,
                   labelText: "Enter your name",
                   namecontroller: nameController,
                 ),
                 const Gap(8),
                 UserInput(
                   datatype: "height",
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                   labelText: "Enter your height in CM",
                   namecontroller: heightController,
                 ),
                     const Gap(8),
                 UserInput(
                   datatype: "weight",
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                   labelText: "Enter your weight in KG",
                   namecontroller: weightController,
                 ),
                 const Gap(12),
                const Text("Select Gender",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  SelectGenderButtons( selectedgender: selectedgender),
                 
                const Gap(18),
                Container(
                  height: 45,
                  width: 45,
                  color: Colors.white,

                  child: TextButton(
                  
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      HomePage(gender: selectedgender,
                      username: nameController.text,
                        height: heightController.text,weight: weightController.text,)));
                    }, 
                    child: const Icon(Icons.done,size: 40,)),
                )
             
             
               ],
               
               
             ),
           ),
         ),
      
          
        ),

        ]
      ),
    );
  }
}
