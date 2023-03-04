import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class serchdetail extends StatefulWidget{
  createState() => serchdetailstate();
}

class serchdetailstate extends State<serchdetail>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0.5,
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.white,
         systemNavigationBarIconBrightness: Brightness.dark,
       ),
       backgroundColor: Colors.white,
       foregroundColor: Colors.black,
       leadingWidth: 15,
       automaticallyImplyLeading: true,
       title: Container(
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.grey.shade200,
         ),
         margin: const EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 15),
          padding: const EdgeInsets.only(top: 0,right: 10,left: 10,bottom: 0),
         child:TextField(
           clipBehavior: Clip.hardEdge,
           keyboardType: TextInputType.text,
           decoration: InputDecoration(
             hintText: "search",
             border: InputBorder.none,
               hintStyle: TextStyle(
             color: Colors.black,
             fontSize: 14,
             fontWeight: FontWeight.w500,
           ),
           ),
           onChanged: (val){

           },
         ),
       ),
     ),
     body: Container(
      child: ListView.builder(
          itemCount: postdata1.length ?? 0,
          itemBuilder: (context, index){
     Datum data1;
     data1 = postdata1[index];
        return Container(
        height: 20,
          color: Colors.red,
        child: Text(data1.owner.firstName),
        );
      }),
     ),
   );
  }

}