import 'dart:async';
import 'dart:collection';

import 'package:demo_chat/Model/commentModel.dart';
// import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:demo_chat/Vm/Vm_User.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/ProfileView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class serchdetail extends StatefulWidget{
  var fromscreen = "";
  serchdetail({ this.fromscreen});
  createState() => serchdetailstate();
}

class serchdetailstate extends State<serchdetail>{
  StreamController<String> searchlistcontroller = StreamController.broadcast();
  Vm_User _vm_user = Vm_User();
  @override
  void initState() {
    // TODO: implement initState
    _vm_user.getUserlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     resizeToAvoidBottomInset: false,
     backgroundColor: Colors.white,
     appBar: AppBar(
       toolbarHeight: 70,
       elevation: 0.0,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
         systemNavigationBarColor: Colors.red,
         systemNavigationBarIconBrightness: Brightness.dark,
         statusBarIconBrightness: Brightness.dark
       ),
       backgroundColor: Colors.white,
       foregroundColor: Colors.black,
       leadingWidth: 25,
       // automaticallyImplyLeading: true,
       // leading: IconButton(
       //   icon: Icon(Icons.arrow_back, color: Colors.black54,), onPressed: () {  Navigator.pop(context);},
       // ),
       title: Padding(
         padding: const EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 25),
         child: Container(
           // width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Colors.grey.shade200.withOpacity(0.5),
           ),
           foregroundDecoration: BoxDecoration(
             border: Border.all(color: Colors.black54.withOpacity(0.4)),
             borderRadius: BorderRadius.circular(10),
           ),
           margin: const EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 25),
            padding: const EdgeInsets.only(top: 0,right: 10,left: 10,bottom: 0),
           child:TextField(
             clipBehavior: Clip.hardEdge,
             keyboardType: TextInputType.text,
             decoration: const InputDecoration(
               hintText: "search",
               border: InputBorder.none,
                 hintStyle: TextStyle(
               color: Colors.black,
               fontSize: 14,
               fontWeight: FontWeight.w500,
             ),
             ),
             onChanged: (val){

             },
           ),
         ),
       ),
     ),
     body: Container(
      child: StreamBuilder<bool>(
        initialData: false,
        stream: _vm_user.searchlistcontroller.stream,
        builder: (context, snapshot) {
          List list = [];
          if(snapshot.data == false){
            // list = getsortedlist(postdata1);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10,left: 10),
              itemCount:  _vm_user.userList.length,
              itemBuilder: (context, index){
     Owner data1;
     data1 = _vm_user.userList[index];
            return InkWell(
              onTap: ()async{
                if(widget.fromscreen == "message"){
                  Map<String, dynamic> map = LinkedHashMap();
                  map['members'] = [Usersprofile.uid,data1.id];
                  map['messages'] = [];
                  DocumentReference data =  firestore.collection("1234567890").doc();
                  String Docid = data.id;
                  firestore.collection("1234567890").doc(data.id).set(map).whenComplete(()async{
                    setchatid(Docid,data1.id,Usersprofile);
                  });
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>profileView(isuser:false,userInfo: data1,)));
                }
              },
              child: Container(
              // height: 20,
                // color: Colors.red,
              child: Row(
                children: [
              Container(
              margin: const EdgeInsets.only(left:0,right: 10),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
                //color:color.elementAt(index),
              ),
                  padding: const EdgeInsets.all(8),
                  child:  CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius:24,
                  backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
                  foregroundImage: data1 == null || data1.picture == null ? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") : NetworkImage(data1.picture)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data1.firstName,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                      Text(data1.firstName +" "+ data1.lastName,style: TextStyle(
                        color: Colors.grey,
                      ),),
                    ],
                  ),
                ],
              ),
              ),
            );
          });
        }
      ),
     ),
   );
  }

  void setchatid(String docid, String id, User usredetails)async{
    var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(usredetails.uid);
    // userdetails = credential.user;
    DataSnapshot length =  await ref.child("chats").once();
    List len = length.value ?? [];
    ref.child("chats").child(len.length.toString()).set(docid).whenComplete(()async{
      print("done");

      var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(id);
      // userdetails = credential.user;
      DataSnapshot length =  await ref.child("chats").once();
      List len = length.value ?? [];
      ref.child("chats").child(len.length.toString()).set(docid).whenComplete(() {
        print("done");
      }).onError((error, stackTrace) =>print("error"));
      Navigator.pop(context);
    }).onError((error, stackTrace) =>print("error"));

  }

  // List getsortedlist(List postdata1) {
  //   List list = [];
  //   for( Datum data1 in postdata1){
  //
  //   }
  //   return list;
  // }

}