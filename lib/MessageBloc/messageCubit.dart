import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/Model/userdetail.dart';

import '../globalfunction.dart';
import 'cubitstate.dart';

class messageCubit extends Cubit<cubitstate>{
  // Stream<DocumentSnapshot> initistate;
  messageCubit() : super(cubitinitialstate());

  // static DocumentSnapshot? get snapshot => null;



  void fetchmessagedetails(messagelist)async{
   var res = FirebaseFirestore.instance.collection("1234567890").doc(messagelist.toString()).snapshots();
    res.listen((event){
       var memberslist = event.get('members') ?? [];
       var memberid;
       userdetail user = userdetail();
       // userdetail user = userdetail();
       for(int i=0;i<memberslist.length;i++){
         if(memberslist[i] != Usersprofile.uid){
           memberid = memberslist[i];
         }
       }
       emit(cubitdatareceived(memberslist:event.get('members'),memberID: memberid));
       // emit(state)
     // }
   }).onError(handleError);

  }

  void handleError(object,trace) {
    emit(cubitloadfailstate());
  }
}