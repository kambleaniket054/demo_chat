import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class userdetail{
  String name = "";
  var profileimage;
  String username = "";
  String createddate = "";
  userdetail({required this.name, required this.createddate, this.profileimage, required this.username});
}