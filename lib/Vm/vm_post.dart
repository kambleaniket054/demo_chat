import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:demo_chat/APi/api_post.dart';
import 'package:demo_chat/Model/commentModel.dart';
import 'package:demo_chat/globalfunction.dart';

import '../Model/instaPostmodel.dart';

class vm_post{
  StreamController<bool> postcontroller  = StreamController<bool>.broadcast();
    // var data;
api_post _apipost = api_post();
  getpost({ String? url}) async {
    try {
      var res = await _apipost.getpost('https://dummyapi.io/data/v1/post?limit=100');
      postdata1 = (res['data']).map((i) => Datum.fromJson(i)).toList();
         for(Datum data in postdata1){
           Map<String,dynamic> commentmap = HashMap();
          commentmap["id"] = data.id;
           // var commentstreams = commentmap['commentStream'];
           commentmap['data1']= data;
      var commentdata =  await getcommentslist(commentmap);
       // data.commentlist = commentdata;
         }
      postcontroller.add(true);
      return res;
    }  catch (e) {
      print(e.toString());
    }
  }
  getprofile({ String? id}) async {
    //var res = "https://i.stack.imgur.com/l60Hf.png";
     var res = await _apipost.getprofile('https://dummyapi.io/data/v1/user?${id}');
     res ??= "https://i.stack.imgur.com/l60Hf.png";
    // data = (res['data']).map((i) => Datum.fromJson(i)).toList();
    postcontroller.add(true);
    return res.toString();
  }

   getcommentslist(Map<String, dynamic> commentmap)async{
    var res;
    // Map data = HashMap();
    // data.values.elementAt(0);
   var id =  commentmap["id"];
   // var commentstreams = commentmap['commentStream'];
   var data1 = commentmap['data1'];
    try {
       res = await _apipost.getCommentsList('https://dummyapi.io/data/v1/post/${id}/comment?limit=10');
      var data = CommentModel.fromJson(res);
       // var data =  await _vmpost.getcommentslist(id);
       data1.commentlist = data ;
      // return data;
      //  commentstreams.add(true);
       return res;
    }  catch (e) {
     print(e.toString());
     return CommentModel.fromJson(res.values.elementAt(0));
    }
  }
}