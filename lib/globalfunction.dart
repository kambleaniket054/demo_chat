import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late GlobalKey<NavigatorState> mainnavigationkey;
late GlobalKey<NavigatorState> navigationkeys;
 List<dynamic> postdata1 =[];
var data;
pushScreenname(BuildContext context, var data){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>data));
}

createTextThemeWise(String value, TextStyle style){
  return Text(value, style: style,textAlign: TextAlign.center,);
}