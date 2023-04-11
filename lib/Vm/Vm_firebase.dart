import '../WebServices/WebServices.dart';

class Vm_firebase{

  void fetchdatabase() async {

    var res = await getRequest("https://demochat-6f628-default-rtdb.firebaseio.com.json");
    return res;
  }

}