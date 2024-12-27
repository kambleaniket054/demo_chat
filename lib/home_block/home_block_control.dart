import 'dart:async';

import 'package:bloc/bloc.dart';

import '../Vm/vm_post.dart';
import 'HomeEvents.dart';
import 'HomeState.dart';
class HomeBlockControl extends Bloc<homeevent,homestate>{
  HomeBlockControl() : super(Homeinitialize()){
    on<homefetchevent>(homeinitialfetchevent);
    on<homeevent>((event, emit){

    });
  }
  vm_post _vmpost = vm_post();

  FutureOr<void> homeinitialfetchevent(homefetchevent event, Emitter<homestate> emit)async {
    List postlist = [];
    emit(Homeloadingstate());
   try {
      postlist = await _vmpost.getpost();
      // postlist ??= [];
      // postlist.insert(4,Datum(id: "", image: "", likes: "0", tags:[], text: "", publishDate: DateTime.now(), owner: Owner(), isfirebase: false,Ads: true));
   } on Exception catch (e) {
    emit(HomeDatareceiveError());
   }
   try {
     emit(HomeDatareceivedsuccess(postlist));
   } on Exception catch (e) {
    print(e.toString());
   }
  }
}



