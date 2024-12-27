import 'dart:async';
import 'dart:collection';

import 'package:demo_chat/Model/userdetail.dart';
import 'package:demo_chat/Vm/Vm_firebase.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/profileBloc/profileEvent.dart';
import 'package:demo_chat/profileBloc/profileState.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import '../Model/profileDetailModel.dart';
import '../globalfunction.dart';

class profilecontroller extends Bloc<profileEvent,profileState>{
  final Vm_firebase _vm_firebase = Vm_firebase();
  final vm_post _vm_post = vm_post();
  profilecontroller() : super(profileinitState(ProfileDetailModel(email: ''))){
    on<fecthprofiledetails>(fetchprofiledetails);
  }


  FutureOr<void> fetchprofiledetails(fecthprofiledetails event, Emitter<profileState> emit) async {
  if(event.isFirebase){
    var res = await _vm_firebase.getprofileDetails(event.uid);
    var profiledetail = ProfileDetailModel.fromJson(res);
    if(res == null){
      emit(profileErrorresponse());
    }
    else{
      emit(profileDateReceived(profiledetail,false,false));
    }
  }
  else{
    var res = await _vm_post.getprofile(id:event.uid);
    var profiledetail = ProfileDetailModel();
    profiledetail.chats = [];
    profiledetail.creationdate =DateTime.parse(res['registerDate']);
    profiledetail.email = res['email'];
    profiledetail.photourl = res['picture'];
    profiledetail.followers = res['followers'];
    profiledetail.following = res['following'];
    profiledetail.username = res['firstName'] + res['lastName'];
    if(res != null){
      bool following = false;
      var res = await _vm_firebase.getprofileDetails(Usersprofile.uid);
      var Ownerprofile = ProfileDetailModel.fromJson(res);
      // Ownerprofile.chats = [];
      var followerslist = Ownerprofile.following.values;
      print(followerslist);
      if(followerslist.contains(event.uid)){
        following = true;
      }
      emit(profileDateReceived(profiledetail,false,following));
    }
    else{
      emit(profileErrorresponse());
    }
  }
  }
}