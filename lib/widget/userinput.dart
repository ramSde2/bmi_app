
import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
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
  Widget build(BuildContext context) {
   
    return Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(datatype,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),), 
                        
              Container(
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius:BorderRadius.circular(2)),
                width: 300,
                
                child: TextField(
                  
                  keyboardType: keyboardType,
                  
                  controller: namecontroller,
                  decoration: InputDecoration(labelText: labelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  
                  
                            
                  
                 
                    alignLabelWithHint: true),
                
                ),
              )
              
                    ],
    );
  }
}


