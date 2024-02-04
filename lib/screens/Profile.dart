// ignore_for_file: must_be_immutable

import 'package:app_demo/model/user.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:app_demo/widget/adddatadialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

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
  DatabaseHelper databaseHelper = DatabaseHelper();
 late List<User> userlist = [];
 int count=0;
 void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<User>> noteListFuture = databaseHelper.getNoteList();
			noteListFuture.then((noteList) {
				setState(() {
				  userlist = noteList.toList();
				  count = noteList.length;
				});
			});
		});
  }
  
  void _delete(BuildContext context, User note) async {

		int result = await databaseHelper.deleteNote(note.id);
		if (result != 0) {
			
			updateListView();
		}
	}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  
  @override
  Widget build(BuildContext context) {
    
    String gender=widget.gender==0?"Male":"Female";
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddDataDialog();
                  },
                );
              },
            ),
          ],
          title: Text("Profile"),
          forceMaterialTransparency: true,
             ),
        backgroundColor:Colors.red,
       
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  
                    decoration: const BoxDecoration(
                      color: Colors.red,
                        // image: DecorationImage(
                        //     image: AssetImage("assets/images/bg-profile.png"),
                        //     fit: BoxFit.cover)
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
                                    child: Text(widget.username,
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
                                            Text(widget.weight,
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
                                            Text(widget.height,
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
                                      itemCount: 4 ,
                                      itemBuilder: (context, index) {
                                      
                                        return Card(
                                    margin: EdgeInsets.all(16),
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Height: {userlist[index].height} cm', style: TextStyle(fontSize: 18.0)),
                                          Text('Weight: {userlist[index].weight} kg', style: TextStyle(fontSize: 18.0)),
                                          Text('Date: {userlist[index].date}', style: TextStyle(fontSize: 18.0)),
                                          SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    
                                                  });
                                                 showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                  return AddDataDialog();
                                  },
                                );
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