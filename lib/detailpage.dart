import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class detailpage extends StatefulWidget{
  createState()=>detailpagestate();
}
class detailpagestate extends State<detailpage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text("Details",style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),),
      ),
      body:Container(color:Colors.white),
    );
  }

}