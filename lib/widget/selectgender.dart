import 'package:flutter/material.dart';

class SelectGenderButtons extends StatefulWidget {
  int selectedgender;
  
 

 SelectGenderButtons({required this.selectedgender});

  @override
  State<SelectGenderButtons> createState() => _SelectGenderButtonsState();
}

class _SelectGenderButtonsState extends State<SelectGenderButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
  Radio(value: 0, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes!;
      
    });
  }),
  Text("Male",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), ),
  Radio(value: 1, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes!;
      
    });
  }),
  Text("FeMale",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), ),
  Radio(value: 2, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes!;
      
    });
  }),
  Text("Other",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), )


],);
  }
}