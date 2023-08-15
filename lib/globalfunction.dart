import 'dart:async';

import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_photo/widget/dragable_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
late GlobalKey<NavigatorState> mainnavigationkey;
late GlobalKey<NavigatorState> navigationkeys;
GoogleSignInAccount? userdata;
late User usredetails;
late  PickedFile pickedFile;

StreamController<bool> datacontroller = StreamController<bool>.broadcast();
late  List<DragableWidget> Listwidgets = [];
 List<dynamic> postdata1 =[];
var data;
FirebaseFirestore firestore = FirebaseFirestore.instance;



pushScreenname(BuildContext context, var data){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>data));
}

createTextThemeWise(String value, TextStyle style){
  return Text(value, style: style,textAlign: TextAlign.center,softWrap: true,);
}