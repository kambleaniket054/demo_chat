import 'package:demo_chat/arfilterscreen.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homepage extends StatefulWidget{
  createState() => homepagestate();  
}
class homepagestate extends State<homepage>{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black,
         systemNavigationBarIconBrightness: Brightness.light,
       ),
       backgroundColor: Colors.white,
       elevation:0,
       automaticallyImplyLeading: false,
       title: const Text("Home",style: TextStyle(
         color: Colors.black,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
     ),
     body: GestureDetector(
         onHorizontalDragStart: (details){
           if(details.globalPosition.dx <= 30.5){
             pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
           }
         },
         child:body() /*Container(color:Colors.white)*/),

   );
  }
  var color = {Colors.amber,Colors.brown,Colors.lime,Colors.lightGreen,Colors.red,Colors.greenAccent,Colors.cyan,Colors.lightBlue};
  
  Widget body(){
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width,
          height:68,
          child: ListView.builder(
            scrollDirection:Axis.horizontal,
            shrinkWrap: true,
            itemCount: color.length,
            itemBuilder:(context,index){
              return Container(
                margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:color.elementAt(index),
                ),
                padding: EdgeInsets.all(10),
                child: const Text("hiii",style: TextStyle(fontSize: 24,color: Colors.black),),

              );
            },
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: color.length,
            itemBuilder: (context,index){
          return Container(width: MediaQuery.of(context).size.width,height: 120,color: color.elementAt(index),margin: EdgeInsets.all(10),);
        }),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10),),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),


          ],
        ),
      ],
    );
  }

}