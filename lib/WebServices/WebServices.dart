import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'app-id':'63ad2b1e900d4a52d4c43a22',
};

Future getRequest(String url, {var header}) async {
  // logText("URL >> $url");
print(url);
  var uri = Uri.parse(url);
  var response;
  if(header == null){
    response = await http.get(uri,headers: requestHeaders);
  }else{
    response = await http.get(uri, headers: requestHeaders);
  }

  if (response.statusCode != 200) {
    return null;
  }
   print(response.body);
  var toJsonData = json.decode(response.body);
  // getdata();
  return toJsonData;
}

// void getdata()async{
//  var response = await http.get(Uri.parse("https://demochat-a3c66-default-rtdb.asia-southeast1.firebasedatabase.app/facetexture"));
//  log(response.body);
// }