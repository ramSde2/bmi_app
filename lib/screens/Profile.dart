import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  
  @override
  Widget build(BuildContext context) {
    String gender=widget.gender==0?"Male":"Female";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card( 
                child: Padding(
                  padding: const EdgeInsets.only(top:18.0,bottom: 5),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                  
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person,size: 35,),
                           const Gap(4),
                          Text(widget.username,style: TextStyle(color: Colors.black,fontSize: 18),),
                      const Gap(10),
                          Text(gender,style: TextStyle(color: Colors.black,fontSize: 18),),
                          const Gap(4),
                          Icon(Icons.male,size: 35,)
                          
                       ],
                  
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                       
                        children: [
                          Text("Height: ${widget.height} CM",style: TextStyle(color: Colors.black,fontSize: 18),),
                          
                          Text("Weight : ${widget.weight} KG",style: TextStyle(color: Colors.black,fontSize: 18),),
                          
                       ],
                       
                      ),
                    ],
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}