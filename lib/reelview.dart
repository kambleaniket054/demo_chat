import 'package:demo_chat/librarypage.dart';
import 'package:flutter/material.dart';

class reelview extends StatefulWidget{
  createState()=>reelviewstate();
}
class reelviewstate extends State<reelview>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return librarypage();
      });
  }
}