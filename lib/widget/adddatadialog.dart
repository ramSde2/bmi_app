import 'package:flutter/material.dart';

class AddDataDialog extends StatefulWidget {
  @override
  _AddDataDialogState createState() => _AddDataDialogState();
}

class _AddDataDialogState extends State<AddDataDialog> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Data"),
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
                  // Perform actions with the entered data if needed
                  // For now, just close the dialog
                  Navigator.of(context).pop();
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