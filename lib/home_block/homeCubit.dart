import 'package:bloc/bloc.dart';

import 'homecubitstate.dart';

class homeCubit extends Cubit<homecubitstate>{
  homeCubit() : super(likebuttonstateinit());

  void onlikedbuttonclicked(){
    emit(onlikebuttonclicked());
  }
}