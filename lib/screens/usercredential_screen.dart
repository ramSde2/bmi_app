import 'package:app_demo/model/user.dart';
import 'package:app_demo/screens/HomePage.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:app_demo/widget/selectgender.dart';
import 'package:app_demo/widget/userinput.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
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
 
 
 Future addUser({required String name, required String gender}) async{
    SharedPreferences prefrence = await SharedPreferences.getInstance();
    prefrence.setString("name", name);
    
    prefrence.setString("gender", gender);
    prefrence.setBool("isProfileSet", true);
    // prefrence.setString("gender", gender);

  }

void _save() async {
  Database db=await openDatabase(
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
var helper= DatabaseHelper(db);

  User _user = User(
    DateFormat("yyyy-MM-dd").format(DateTime.now()),
    heightController.text.toString(),
    weightController.text.toString(),
  );

  try {
    await helper.insert(_user);
    print(" data saved succesfully");
  } catch (e) {
  print("erro  in data daving");
  }
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
  String gender=SelectGenderButtons().selectedgender==0?"Male":"Female";
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
                                                  addUser(name:nameController.text.toString() , gender: gender);

                        
                         setState(() {
                           _save();
                                                      addUser(name:nameController.text.toString() , gender: gender);

                           print(nameController.text.toString());
                         print(gender);
                         
                         
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
