import '../WebServices/WebServices.dart';

class Vm_firebase{

   fetchdatabase() async {
    var res = await getRequest("https://demochat-6f628-default-rtdb.firebaseio.com.json");
    return res;
  }

  getprofileDetails(String uid)async{
     var res = await getRequest("https://dotchat-c76a1-default-rtdb.asia-southeast1.firebasedatabase.app/Userdetails/${uid}.json");
     return res;
  }
}