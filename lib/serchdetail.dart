import 'package:flutter/material.dart';

class serchdetail extends StatefulWidget{
  createState() => serchdetailstate();
}

class serchdetailstate extends State<serchdetail>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: true,
     ),
     body: Container(
       color: Colors.white,
     ),
   );
  }

}