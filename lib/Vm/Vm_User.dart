import 'dart:async';

import 'package:demo_chat/Model/commentModel.dart';
import 'package:demo_chat/WebServices/WebServices.dart';

class Vm_User{
  List userList = [];
  StreamController<bool> searchlistcontroller = StreamController<bool> .broadcast();
  getUserlist()async{
    var temp = [];
    var res = await getRequest("https://dummyapi.io/data/v1/user?limit=100");
    for(int i=0;i<res["data"].length;i++){
      var tempmodel = res["data"][i];
      temp.add(Owner(id: tempmodel["id"], title: tempmodel["title"], firstName: tempmodel["firstName"], lastName: tempmodel["lastName"], picture: tempmodel["picture"]));
    }
    userList = temp;
    searchlistcontroller.add(true);
    // return userList;
  }
}