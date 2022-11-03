import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late GlobalKey<NavigatorState> mainnavigationkey;
late GlobalKey<NavigatorState> navigationkeys;

pushScreenname(BuildContext context, var data){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>data));
}