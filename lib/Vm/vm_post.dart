import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/APi/api_post.dart';
import 'package:demo_chat/Model/commentModel.dart';
import 'package:demo_chat/globalfunction.dart';

import '../Model/instaPostmodel.dart';

class vm_post{
  StreamController<bool> postcontroller  = StreamController<bool>.broadcast();
    // var data;
api_post _apipost = api_post();
  getpost({ String url}) async {
    try {
      var res = await _apipost.getpost('https://dummyapi.io/data/v1/post?limit=100');
      postdata1 = (res['data']).map((i) => Datum.fromJson(i)).toList();
      var ref = firestore.collection("12345678").orderBy("publishDate",descending: false);
      QuerySnapshot querySnapshot = await ref.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        Map<String,dynamic> postdetails = doc.data() as Map<String, dynamic>;
        postdetails["postid"] = doc.id;
        return postdetails;
      });
      print(ref);
      allData.forEach((element) {
        Map<String, dynamic> data = element as Map<String, dynamic>;
        Datum dtam = Datum.fromJson(data);
        dtam.isfirebase = true;
        dtam.postid = data["postid"];
        postdata1.add(dtam);
      });
      // for(int i= 0;i<allData.length;i++){

        // Datum dtam = Datum(id: allData[i]["id"], image: allData[i]["image"], likes: int.parse(allData[i]["likes"]), tags: allData[i]["tags"], text: allData[i]["text"]??"", publishDate: (allData[i]["publishDate"] as Timestamp).toDate(), owner: allData[i]["owner"], isfirebase:true);
        // postdata1.add(dtam);
      // }
      // postcontroller.add(true);
      return postdata1;
    } catch (e) {
      print(e.toString());
    }
  }

  getuserPost({String id})async{
  var res = await _apipost.getpost('https://dummyapi.io/data/v1/user/${id}/post?limit=10');
  if(res == null){
    return null;
  }
  List profilepost = (res['data']).map((i) => Datum.fromJson(i)).toList();
  print(res);
  return profilepost;
}


  getprofile({String id}) async {
    //var res = "https://i.stack.imgur.com/l60Hf.png";
     var res = await _apipost.getprofile('https://dummyapi.io/data/v1/user/${id}');
     // res ??= "https://i.stack.imgur.com/l60Hf.png";
    // data = (res['data']).map((i) => Datum.fromJson(i)).toList();
    postcontroller.add(true);
    return res;
  }

  getcommentslist(Map<String, dynamic> commentmap)async{
    var res;
   var id =  commentmap["id"];
   StreamController commentstreams = commentmap['commentStream'];
   var data1 = commentmap['data1'];
    try {
       res = await _apipost.getCommentsList('https://dummyapi.io/data/v1/post/${id}/comment?limit=10');
      var data = CommentModel.fromJson(res);
       data1.commentlist = data ;
       commentstreams.add(true);
    }  catch (e) {
     print(e.toString());
     return CommentModel.fromJson(res.values.elementAt(0));
    }
  }
}