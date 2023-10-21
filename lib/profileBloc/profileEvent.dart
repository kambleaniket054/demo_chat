import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

@immutable
abstract class profileEvent{}

class fecthprofiledetails extends profileEvent{
String uid;
fecthprofiledetails({required this.uid});
}