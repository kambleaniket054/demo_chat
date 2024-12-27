import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/Model/reelsModel.dart';

import '../WebServices/WebServices.dart';
import '../globalfunction.dart';

class Vm_firebase{

   fetchdatabase() async {
    var res = await getRequest("https://dotchat-c76a1-default-rtdb.asia-southeast1.firebasedatabase.app/Reels.json?auth=${Usersprofile.uid}",header: {});
    var data  =  (res.values).map((i) => ReelsModel.fromJson(i)).toList();
    // var newdata =
    return data;

  }

  getprofileDetails(String uid)async{
     var res = await getRequest("https://dotchat-c76a1-default-rtdb.asia-southeast1.firebasedatabase.app/Userdetails/${uid}.json");
     return res;
  }
  getUserPost(String uid)async{
     // var Query = {
     //   "structuredQuery":{
     //     "from":[
     //       {
     //         "collectionId":"12345678"
     //       }
     //     ],
     //     "where":{
     //         "filters":[
     //           {
     //             "fieldFilter":{
     //               "field":{
     //                 "fieldPath":"id"
     //               },
     //               "op":"EQUAL",
     //               "value":{
     //                 "stringValue":"${uid}"
     //               }
     //             }
     //           }
     //         ]
     //     }
     //
     //   }
     // };
     // var res  = await getRequest("https://firestore.googleapis.com/v1/projects/dotchat-c76a1/databases/(default)/documents/auth=${uid}:${Query}",header: {});
     // return res;

    QuerySnapshot res = await firestore.collection("12345678").where("id",isEqualTo: "${uid}").get();/*then((value){
      // var Postlist = [];
      // Postlist =  value.docs;
      // return Postlist;
    });*/
   return res;
  }
}