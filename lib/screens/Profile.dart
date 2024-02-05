// ignore_for_file: must_be_immutable

import 'package:app_demo/model/user.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:app_demo/widget/adddatadialog.dart';
import 'package:app_demo/widget/updatedatadailof.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ProfilePage extends StatefulWidget {
  
  
   ProfilePage();
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // DatabaseHelper databaseHelper = DatabaseHelper();
 late List<User> userlist = [];
 String name="";
 String gender="";
 String height="";
 String weight="";
 int count=0;
 Future getUserInfo()async{
    SharedPreferences preferce = await SharedPreferences.getInstance();
    
    name=preferce.getString("name")!;
    gender=preferce.getString("gender")!;
    print(name);
    print(gender);
  }
 void updateListView() async {
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
				  count = noteList.length;
          height=userlist[userlist.length-1].height;
          weight=userlist[userlist.length-1].weight;
				});
			});
      
		
  }

  void _showAddDataDialog(context,) async {
  bool dataUpdated = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddDataDialog();
    },
  );

  if (dataUpdated != null && dataUpdated) {
    // Data is updated, rebuild the state or perform any necessary actions
    updateListView(); 
    // Call your method to update the data in the profile
  }
}
void _showEditDataDialog(context) async {
  bool dataUpdated = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return  UpdataDataDialog();
    },
  );

  if (dataUpdated != null && dataUpdated) {
    // Data is updated, rebuild the state or perform any necessary actions
    updateListView(); // Call your method to update the data in the profile
  }
}
  
  
  // void _delete(BuildContext context, User note) async {

	// 	int result = await databaseHelper.deleteNote(note.id);
	// 	if (result != 0) {
			
	// 		updateListView();
	// 	}
	// }
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    updateListView();
  }

  
  @override
  Widget build(BuildContext context) {
   
    
    
    DateTime dt=DateTime.now();
    String date=DateFormat("yyyy-MM-dd").format(dt);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
               setState(() {
                 
               });
               _showAddDataDialog(context);
                
              },
            ),
          ],
          title: Text("Profile"),
          forceMaterialTransparency: true,
             ),
        backgroundColor:Colors.blueGrey,
       
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  
                    decoration: const BoxDecoration(
                   
                        image: DecorationImage(
                            image: AssetImage("assets/images/bg-profile.png"),
                            fit: BoxFit.cover)
                            ),
                    child: Stack(
                      children: <Widget>[
                        SafeArea(
                         
                          bottom: false,
                          right: false,
                          left: false,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/userprofile.jpg"),
                                      radius: 65.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Text(name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(gender,
                                        style: TextStyle(
                                            color: Colors.white
                                                .withOpacity(0.85),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0, left: 42, right: 32),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                           const Text("Weight In KG",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(weight,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 12.0))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                         const   Text("Height in cms",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(height,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 12.0))
                                          ],
                                        ),
                                         Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                        const    Text("Date",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(date,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 12.0))
                                          ],
                                        )
                                      
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                
                      ],
                    )
                    ),
                Expanded(
                  child: ListView.builder(
                                      itemCount: userlist.length ,
                                      itemBuilder: (context, index) {
                                      
                                        return Card(
                                    margin: EdgeInsets.all(16),
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Height: ${userlist[index].height} cm', style: TextStyle(fontSize: 18.0)),
                                          Text('Weight: ${userlist[index].weight} kg', style: TextStyle(fontSize: 18.0)),
                                          Text('Date: ${userlist[index].date}', style: TextStyle(fontSize: 18.0)),
                                          SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  
                                               _showEditDataDialog(context,);
                                
                                                
                                                
                                                },
                                                child: Text('Edit'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Handle Delete button click
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                                ),
                                                child: Text('Delete',style: TextStyle(color: Colors.black),),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                      );
                     } ),
                ) 
             ],
            ),
             Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 10, bottom: 10),
                            child: Container(
                              
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13)),
                             
                              child: Text("Day Wise Weights",
                                  style: TextStyle(fontSize: 24.0)),
                            )),
                      ),
                    
                   
                   
                  ],
                ),
              ),
            )
          ],
        ));
 
  }
}