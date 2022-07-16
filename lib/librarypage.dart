import 'package:flutter/material.dart';

class librarypage extends StatefulWidget{
  createState()=>librarypagestate();
}
class librarypagestate extends State<librarypage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: true,
       title: Text("Home"),
     ),
     body:Container(color:Colors.white),
   );
  }

}