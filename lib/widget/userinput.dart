
import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  TextInputType keyboardType;
  
  var namecontroller;
  String datatype;
  var labelText;

   UserInput({
    required this.datatype,
    required this.keyboardType,
    required this.namecontroller,
    required this.labelText,

  });

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
String?  _errorText(TextEditingController txt) {
  // at any time, we can get the text from _controller.value.text
  final text = txt.value.text;
  // Note: you can do your own custom validation here
  // Move this logic this outside the widget for more testable code
  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  
  // return null if the text is valid
 return null;
}

  @override
  Widget build(BuildContext context) {
    var _text='';
   
    return Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.datatype,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),), 
                        
              Container(
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius:BorderRadius.circular(2)),
                width: 300,
                
                child: TextField(
                  
                  keyboardType: widget.keyboardType,
                  
                  controller: widget.namecontroller,
                  decoration: InputDecoration(labelText: widget.labelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  errorText: _errorText(widget.namecontroller),
                  
                            
                  
                 
                    alignLabelWithHint: true),
                onChanged: (text) => setState(() => _text),

                ),
              )
              
                    ],
    );
  }
}


