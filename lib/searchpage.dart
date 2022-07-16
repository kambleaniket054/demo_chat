import 'package:flutter/material.dart';

class searchpage extends StatefulWidget{
  createState()=>searchpagestate();
}
class searchpagestate extends State<searchpage>{
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