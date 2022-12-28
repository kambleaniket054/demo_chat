import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/serchdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class searchpage extends StatefulWidget{
  createState()=>searchpagestate();
}
class searchpagestate extends State<searchpage>{
  GlobalKey key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      print(key.currentContext?.size?.width);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){
            Navigator.push(navigationkeys.currentContext!, MaterialPageRoute(builder: (context)=> serchdetail()));
          },
          child: Container(
            key: key,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            margin: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
            child:  Row(
              children:  [
                Icon(Icons.search),
                Container(width: 10/*(key.currentContext?.size?.width)!/2*/,color: Colors.cyan,),
                Text("Search",style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),),
              ],
            ),
          ),
        ),
      ),
      body:Container(color:Colors.white),
    );
  }

}