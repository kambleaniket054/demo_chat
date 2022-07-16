import 'package:flutter/material.dart';

class detailpage extends StatefulWidget{
  createState()=>detailpagestate();
}
class detailpagestate extends State<detailpage>{
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