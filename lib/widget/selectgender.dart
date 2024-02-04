import 'package:flutter/material.dart';

class SelectGenderButtons extends StatefulWidget {
  int? selectedgender;
  
 

 SelectGenderButtons({ this.selectedgender});

  @override
  State<SelectGenderButtons> createState() => _SelectGenderButtonsState();
}

class _SelectGenderButtonsState extends State<SelectGenderButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
  Radio(fillColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.black;
                }
                return Colors.white;
              },
            ),
    value: 0, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes;
      
    });
  }),
  Text("Male",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), ),
  Radio( fillColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.black;
                }
                return Colors.white;
              },
            ),
    value: 1, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes;
      
    });
  }),
  Text("FeMale",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), ),
  Radio
  (fillColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.black;
                }
                return Colors.white;
              },
            ),
    value: 2, groupValue:widget.selectedgender , onChanged: (int? changes){ 
    setState(() {
      widget.selectedgender=changes;
      
    });
  }),
  Text("Other",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400), )


],);
  }
}