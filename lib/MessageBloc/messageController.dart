import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../globalfunction.dart';
import 'messageEvent.dart';
import 'messageState.dart';
class messageController extends Bloc<messageEvent,messageState>{
  messageController() : super(initialmessagestate()){
    on<messagfetchEvent>(messagefetchEventset);
    on<onmessageClicked>(messageclickedevent);
  }




  FutureOr<void> messageclickedevent(onmessageClicked event, Emitter<messageState> emit) {
  }

  FutureOr<void> messagefetchEventset(event, Emitter<messageState> emit) async {
    emit(messageloading());
    List msglist = [];
    var ref = await FirebaseDatabase.instance.reference().child("Userdetails").child(Usersprofile.uid).once().then((value)async{
      // print("firebasedata: ${value.value}");
      msglist = value.value['chats'];
      emit(messagelistfetched(msglist));
      // WidgetsBinding.instance?.addPostFrameCallback((_) =>chatslistcontroller.add(true));
    });

  }
}