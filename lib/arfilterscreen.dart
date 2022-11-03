import 'package:flutter/material.dart';
import 'package:demo_filter/demo_filter.dart';
import 'package:demo_filter/demo_facecontroller.dart';
import 'package:flutter/services.dart';

class arfilterscreen extends StatefulWidget{
  arfilterscreenstate  createState ()=> arfilterscreenstate();
}
class arfilterscreenstate extends State<arfilterscreen>{
  late Demofacecontroller demofacecontroller;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black,
         systemNavigationBarIconBrightness: Brightness.light,

       ),
       toolbarHeight: 30,
       backgroundColor: Colors.black54.withOpacity(0.0),
       automaticallyImplyLeading: true,
     ),

     extendBodyBehindAppBar: true,
     backgroundColor: Colors.black54,
     //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     body:Column(
       children: [
         Expanded(
           child: ClipRRect(
             borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)),
             clipBehavior: Clip.hardEdge,
             child: DemoFilter(
               ondemo_facecontroller: (controller)async{
                 demofacecontroller = controller;
                 demofacecontroller.init();
                 var texture ;
                  try {
                    const String textureBytes = "assets/fox_face_mesh_texture.png";
                     texture = await rootBundle.load(textureBytes);
                    String data;
                    // if(count == 1){
                    data ="yellow_sunglasses.sfb";
                    demofacecontroller.loadmesh(texture,data);
                     // textureBytes = await rootBundle.load('assets/fox_face_mesh_texture.png');
                  }  catch (e) {
                    print(e.toString());
                  }

               },
             ),
           ),
         ),
         Row(
           children: [
             GestureDetector(
               onTap: ()async{
                 var texture ;
                 const String textureBytes = "assets/fox_face_mesh_texture.png";
                 texture = await rootBundle.load(textureBytes);
                 String data;
                 // if(count == 1){
                 data ="fox_face.sfb";
                 demofacecontroller.loadmesh(texture,data);
               },
               child: Container(
                 margin:const EdgeInsets.only(bottom: 12,top: 12,right: 120) ,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(40),
                 ),
                 padding: const EdgeInsets.all(15),
                 child: const Icon(Icons.change_circle,color: Colors.blueGrey,),
               ),
             ),
             GestureDetector(
               onTap: (){
                 demofacecontroller.capture();
               },
               child: Container(
                 margin:const EdgeInsets.only(bottom: 12,top: 12) ,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(40),
                 ),
                 padding: const EdgeInsets.all(15),
                 child: const Icon(Icons.camera,color: Colors.blueGrey,),
               ),
             ),
           ],
         ),
       ],
     ),
    /* floatingActionButton: Padding(
       padding: const EdgeInsets.only(bottom: 12),
       child: GestureDetector(
         onLongPress: (){
           demofacecontroller.capture();
         },
         child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(40),
           ),
           padding: EdgeInsets.all(15),
           child: const Icon(Icons.camera,color: Colors.blueGrey,),

         ),
       ),*//*FloatingActionButton(
         backgroundColor: Colors.white,
         onPressed: () {
         demofacecontroller.capture();
       },
         child:const Icon(Icons.camera,color: Colors.blueGrey,),
       ),*//*
     ),*/
   );
  }

}