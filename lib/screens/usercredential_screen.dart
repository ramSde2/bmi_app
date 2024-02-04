import 'package:app_demo/model/user.dart';
import 'package:app_demo/screens/HomePage.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:app_demo/widget/selectgender.dart';
import 'package:app_demo/widget/userinput.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class UserScreen extends StatefulWidget {
    int selectedgender=0;
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  
  var nameController = TextEditingController();
  DateTime dt=DateTime.now();
  bool  isset=false;
 

  var heightController = TextEditingController();
  var weightController = TextEditingController();
 
DatabaseHelper helper = DatabaseHelper();
 


void _save() async {
final Future<Database> dbFuture = helper.initializeDatabase();
		User _user=User(DateFormat("yyyy-MM-dd").format(DateTime.now()),heightController.text.toString(), weightController.text.toString());
dbFuture.then((database) async{

if (_user.id != null) {  // Case 1: Update operation
			await helper.updatedata(_user);
		}
    else{
 await helper.insert(_user);
    }
			
			
				setState(() {
				  
				});
			});

		}
		
    
  store_to_shared_pref () async
{
SharedPreferences pref=await SharedPreferences.getInstance();
 String  gender=widget.selectedgender==0?"Male":"Female";

await pref.setString("username",nameController.text);
await pref.setString("gender",gender);
await pref.setString("isset","true");



}



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
    
    
    
  }

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
  
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                    SelectGenderButtons( selectedgender: widget.selectedgender),
                   
                  const Gap(18),
                  Container(
                    height: 45,
                    width: 45,
                    color: Colors.white,
        
                    child: TextButton(
                    
                      onPressed: (){
                       
                         store_to_shared_pref ();
                         setState(() {
                           _save();
                         });
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                        HomePage(gender:  SelectGenderButtons().selectedgender.toString(),
                        username: nameController.text,
                          height: heightController.text,weight: weightController.text,)));
                       }
                        
                      , 
                      child: const Icon(Icons.done,size: 40,)),
                  )
               
               
                 ],
                 
                 
               ),
             ),
           ),
        
            
          ),
        
          ]
        ),
      ),
    );
  }
}
