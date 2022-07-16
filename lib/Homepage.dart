import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget{
  createState() => homepagestate();  
}
class homepagestate extends State<homepage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: true,
       title: Text("Home"),
     ),
     body: Container(color:Colors.white),

   );
  }

}