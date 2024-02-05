

import 'package:app_demo/model/user.dart';
import 'package:app_demo/screens/Profile.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:app_demo/widget/barchart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String gender;
   var height;
  var  weight;
  HomePage({ this.height,
    this.weight,required this.gender,required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> userlist = [];

  void getlatestdata() async {
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
		Future<List<User>> noteListFuture = helper.getNoteList();
			noteListFuture.then((noteList) {
        
				setState(() {
				  userlist = noteList.toList();
				  double height=double.parse((userlist[0].weight));
double weight=double.parse((userlist[0].weight));

    bmi= (weight/(height*height))*10000;
				}
        );
			}
      );
		
  }

  double bmi= 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlatestdata();
    
  }
  //bmi formula
  //[weight (kg) / height (cm) / height (cm)] x 10,000
  
 
  @override
  Widget build(BuildContext context) {

      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: false,
        
        title: Text("Hello ${widget.username??"rammmmm"}",style: TextStyle(color: Colors.black,fontSize: 24),),
        automaticallyImplyLeading: false,
        actions: [IconButton( icon: Icon(Icons.person_2), onPressed: () { 
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfilePage()));
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