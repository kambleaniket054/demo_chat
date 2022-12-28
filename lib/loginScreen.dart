import 'dart:ui';

import 'package:demo_chat/Homescreen.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginscreen extends StatefulWidget{
  createState() => loginscreenState();
}

class loginscreenState  extends State<loginscreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor:Colors.black54.withAlpha(115),
     body: Container(
       //color: Colors.red,
       child: Center(
         child: Column(
           children: [
             createTextThemeWise("Demo Chat", const TextStyle(
                 fontSize: 26,
                 height: 14,
                 shadows: [
                   Shadow(color: Colors.red,offset: Offset(1, 1),blurRadius: 5),
                 ],
                 fontStyle: FontStyle.italic,
                 color: Colors.white38,
                 decorationColor: Colors.black54,
             )),
            Container(
              decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              padding: EdgeInsets.only(left: 10,right: 10),
              child: const TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.grey
                ),
                decoration: InputDecoration(
                  hintText: "UserName",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.red,
                  border: InputBorder.none
                ),
              ),
            ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.white12.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(10),
               ),
               margin: EdgeInsets.only(left: 10,right: 10,top: 10),
               padding: EdgeInsets.only(left: 10,right: 10),
               child: TextField(
                 keyboardType: TextInputType.text,
                 style: TextStyle(
                   color: Colors.grey
                 ),
                 decoration: InputDecoration(
                     hintText: "password",
                     hintStyle: TextStyle(color: Colors.grey),
                   floatingLabelBehavior: FloatingLabelBehavior.never,
                   fillColor: Colors.red,
                     border: InputBorder.none
                 ),
               ),
             ),
             InkWell(
               onTap: (){
                 Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
               },
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white12.withOpacity(0.4),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                 padding: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                 child:Text("Login",textAlign: TextAlign.center,style: TextStyle(
                   color: Colors.grey,
                 ),),
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }

}