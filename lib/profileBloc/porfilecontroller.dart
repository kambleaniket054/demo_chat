import 'dart:async';

import 'package:demo_chat/Vm/Vm_firebase.dart';
import 'package:demo_chat/profileBloc/profileEvent.dart';
import 'package:demo_chat/profileBloc/profileState.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import '../Model/profileDetailModel.dart';

class profilecontroller extends Bloc<profileEvent,profileState>{
  final Vm_firebase _vm_firebase = Vm_firebase();
  profilecontroller() : super(profileinitState()){
    on<fecthprofiledetails>(fetchprofiledetails);
  }


  FutureOr<void> fetchprofiledetails(fecthprofiledetails event, Emitter<profileState> emit) async {
   var res = await _vm_firebase.getprofileDetails(event.uid);
   var profiledetail = ProfileDetailModel.fromJson(res);
   if(res == null){
     emit(profileDateReceived(profiledetail));
   }
   else{
     emit(profileDateReceived(profiledetail));
   }
  }
}