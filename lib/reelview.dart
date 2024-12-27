import 'dart:async';

import 'package:demo_chat/Vm/Vm_firebase.dart';
import 'package:demo_chat/librarypage.dart';
import 'package:flutter/material.dart';

import 'Colorcode.dart';

class reelview extends StatefulWidget{
  createState()=>reelviewstate();
}
class reelviewstate extends State<reelview>{
Vm_firebase _vm_firebase = Vm_firebase();
List reels = [];
StreamController<bool> reelscontroller = StreamController.broadcast();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetchreels();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // systemOverlayStyle:
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),),
        elevation: 0,
        automaticallyImplyLeading: false,
        title:  Text("Library",style: TextStyle(
          color: Colorcode.foreground,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
            textScaleFactor: 1.0
        ),
      ),
      body: StreamBuilder<bool>(
        stream: reelscontroller.stream,
        initialData: false,
        builder: (context, snapshot) {
          return snapshot.data == false ?const Center(child: CircularProgressIndicator(),): PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            itemBuilder: (context, index) {
              return librarypage(reels[index]);
            });
        }
      ),
    );
  }

  void fetchreels() async{
    reels =  await _vm_firebase.fetchdatabase();
    print(reels);
    reelscontroller.add(true);
  }
}