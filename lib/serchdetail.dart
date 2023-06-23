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
       toolbarHeight: 70,
       elevation: 0.0,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
         systemNavigationBarColor: Colors.red,
         systemNavigationBarIconBrightness: Brightness.dark,
         statusBarIconBrightness: Brightness.dark
       ),
       backgroundColor: Colors.white,
       foregroundColor: Colors.black,
       leadingWidth: 25,
       // automaticallyImplyLeading: true,
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.black54,), onPressed: () {  Navigator.pop(context);},
       ),
       title: Padding(
         padding: const EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 25),
         child: Container(
           // width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Colors.grey.shade200.withOpacity(0.5),
           ),
           foregroundDecoration: BoxDecoration(
             border: Border.all(color: Colors.black54.withOpacity(0.4)),
             borderRadius: BorderRadius.circular(10),
           ),
           margin: const EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 25),
            padding: const EdgeInsets.only(top: 0,right: 10,left: 10,bottom: 0),
           child:TextField(
             clipBehavior: Clip.hardEdge,
             keyboardType: TextInputType.text,
             decoration: const InputDecoration(
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
     ),
     body: Container(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10,left: 10),
          itemCount: postdata1.length,
          itemBuilder: (context, index){
     Datum data1;
     data1 = postdata1[index];
        return Container(
        // height: 20,
          // color: Colors.red,
        child: Row(
          children: [
        Container(
        margin: const EdgeInsets.only(left:0,right: 10),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
          //color:color.elementAt(index),
        ),
            padding: const EdgeInsets.all(8),
            child:  CircleAvatar(
            backgroundColor: Colors.orange,
            radius:30,
            backgroundImage:NetworkImage(data1.owner.picture))
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data1.owner.firstName,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                Text(data1.owner.firstName +" "+ data1.owner.lastName,style: TextStyle(
                  color: Colors.grey,
                ),),
              ],
            ),
          ],
        ),
        );
      }),
     ),
   );
  }

}