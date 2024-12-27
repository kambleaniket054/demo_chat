import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

@immutable
abstract class profileEvent{}

class fecthprofiledetails extends profileEvent{
String uid;
bool isFirebase = true;
fecthprofiledetails({ this.uid, this.isFirebase});
}