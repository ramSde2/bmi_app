import 'package:app_demo/model/user.dart';
import 'package:app_demo/screens/Profile.dart';
import 'package:app_demo/util/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UpdataDataDialog extends StatefulWidget {
  @override
  _UpdataDataDialogState createState() => _UpdataDataDialogState();
}

class _UpdataDataDialogState extends State<UpdataDataDialog> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  void _save(context) async {
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
    await helper.updatedata(_user);
    Navigator.pop(context,true);
    print(" data saved succesfully");
  } catch (e) {
  print("erro  in data daving");
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update  Data"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Height (cm)",
              prefixIcon: Icon(Icons.height),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Weight (kg)",
              prefixIcon: Icon(Icons.fitness_center),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _save(context);
                 
                  
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.orange,
                ),
                child: Text("OK"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}