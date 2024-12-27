import 'package:bloc/bloc.dart';
import 'package:demo_chat/Vm/Vm_firebase.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/profileBloc/cubitState.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/instaPostmodel.dart';
// import 'profilecubitState.dart';
vm_post _vm_post = vm_post();
Vm_firebase _vm_firebase = Vm_firebase();
class ProfileCubit extends Cubit<profilecubitState>{
  ProfileCubit() : super(cubitinitialState());

  void fetchprofilePost(String uid, {bool isfirebase = false})async{
    try {
      var res;
       if (!isfirebase) {
         res = await _vm_post.getuserPost(id:uid);
       }
       else{
         var templist = [];
         var postres = await _vm_firebase.getUserPost(uid);
         QuerySnapshot querySnapshot = postres;
         // Get data from docs and convert map to List
         final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
         print(allData);
         for(int i= 0;i<allData.length;i++){
          Map data = allData[i] as Map;
           Datum dtam = Datum(id: data["id"], image: data["image"], likes: data["likes"].toString(), tags:data["tags"], text:data["text"]??"", publishDate: (data["publishDate"] as Timestamp).toDate(), owner: Owner(
             id:data["owner"]["id"]?? "",
             title: titleValues.map[data["owner"]["title"]] ?? titleValues.map["MR"],
             firstName: data["owner"]["firstName"] ?? "",
             lastName: data["owner"]["lastName"] ?? "",
             picture: data["owner"]["picture"]??"",
           ),
               isfirebase:true,
           );
           templist.add(dtam);
           // postdata1.add(dtam);
         }
         res = templist;
       }
      if(res == null){
        emit(profilePostError());
      }
      else {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          emit(profilePostDatatReceived(res));
        });

      }
      print(res);
    } on Exception catch (e) {
      print(e.toString());
      emit(profilePostError());
      // TODO
    }
  }

}