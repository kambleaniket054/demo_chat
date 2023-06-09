// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:demo_chat/Vm/Vm_firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:demo_filter/demo_filter.dart';
// import 'package:demo_filter/demo_facecontroller.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
//
// class arfilterscreen extends StatefulWidget{
//   arfilterscreenstate  createState ()=> arfilterscreenstate();
// }
// class arfilterscreenstate extends State<arfilterscreen>{
//   late Demofacecontroller demofacecontroller;
//   String data = "";
//   String textureBytes = "";
//   var texture ;
//   late final dbobj;
//   var datalist;
//   Vm_firebase firebasedatabase = Vm_firebase();
//   StreamController modeldatacontroller = StreamController<bool>.broadcast();
//   List dat = [];
//   int count = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getfirebasedata();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        systemOverlayStyle:const SystemUiOverlayStyle(
//          systemNavigationBarColor: Colors.black,
//          systemNavigationBarIconBrightness: Brightness.light,
//
//        ),
//        toolbarHeight: 30,
//        backgroundColor: Colors.black54.withOpacity(0.0),
//        automaticallyImplyLeading: true,
//      ),
//
//      extendBodyBehindAppBar: true,
//      backgroundColor: Colors.black54,
//      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      body:Column(
//        children: [
//          Expanded(
//            child: ClipRRect(
//              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)),
//              clipBehavior: Clip.hardEdge,
//              child: DemoFilter(
//                ondemo_facecontroller: (controller)async{
//                  demofacecontroller = controller;
//
//                  try {
//                   /* final appDocDir = await getApplicationDocumentsDirectory();
//                    final filePath = "${appDocDir.absolute}/images/nosecircle.gltf";
//                    final file = File(filePath);
//                     // final gsReference = FirebaseStorage.instance.refFromURL("gs://demochat-51a0d.appspot.com/native_face.png");
//                      final gsrefobj =  FirebaseStorage.instance.ref();
//                     var news = await gsrefobj.child("nosecircle.gltf").getDownloadURL();
//                      var data = await http.get(Uri.parse(news.toString()));
//                      var res = data.body;
//                      try {
//                        file.writeAsString(res.toString());
//                        //var path = await gsrefobj.writeToFile(file);
//                        *//*path.snapshotEvents.listen((event) {
//                          if(event == "success"){
//                            demofacecontroller.loadmesh("gs://demochat-6f628.appspot.com/native_face.png",file.uri.toString());
//                          }
//                        print("write response----------------->"+event.state.name);
//                                           });*//*
//                      } on Exception catch (e) {
//                      print("write error");
//                      }*/
//                       textureBytes = "assets/native_face.png";
//                      // texture =/* await rootBundle.load(textureBytes)*/ await gsReference.getData();
//                     // if(count == 1){
//                     //data ="Mask.sfb";
//
//                      // textureBytes = await rootBundle.load('assets/fox_face_mesh_texture.png');
//                    demofacecontroller.init();
//                       modeldatacontroller.stream.listen((event) {
//                         modedata data  = dat[0];
//                         demofacecontroller.loadmesh(data.texture,data.model);
//                       });
//                  } catch (e) {
//                     print(e.toString());
//                   }
//
//                },
//              ),
//            ),
//          ),
//          Row(
//            children: [
//              GestureDetector(
//                onTap: () async {
//                  count++;
//                 /* var texture ;
//                    if ( textureBytes != "assets/fox_face_mesh_texture.png") {
//                      textureBytes = "assets/fox_face_mesh_texture.png";
//                    }
//                    else{
//                      textureBytes =  "assets/venom.jpg";
//                    }*/
//
//                  // texture = await rootBundle.load(textureBytes);
//
//                  // if(data != "fox_face.sfb"){
//                  //   data = "fox_face.sfb";
//                  // }
//                  // else{
//                  //   data = "yellow_sunglasses.sfb";
//                  // }
//                  if(count > dat.length){
//                    count = 0;
//                  }
//                  modedata data  = dat[count];
//                  demofacecontroller.loadmesh(data.texture,data.model);
//                  // demofacecontroller.loadmesh(texture,data);
//                },
//                child: Container(
//                  margin:const EdgeInsets.only(bottom: 12,top: 12,right: 120) ,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(40),
//                  ),
//                  padding: const EdgeInsets.all(15),
//                  child: const Icon(Icons.change_circle,color: Colors.blueGrey,),
//                ),
//              ),
//              GestureDetector(
//                onTap: (){
//                  demofacecontroller.capture();
//                },
//                child: Container(
//                  margin:const EdgeInsets.only(bottom: 12,top: 12) ,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(40),
//                  ),
//                  padding: const EdgeInsets.all(15),
//                  child: const Icon(Icons.camera,color: Colors.blueGrey,),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//     /* floatingActionButton: Padding(
//        padding: const EdgeInsets.only(bottom: 12),
//        child: GestureDetector(
//          onLongPress: (){
//            demofacecontroller.capture();
//          },
//          child: Container(
//            decoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.circular(40),
//            ),
//            padding: EdgeInsets.all(15),
//            child: const Icon(Icons.camera,color: Colors.blueGrey,),
//
//          ),
//        ),*//*FloatingActionButton(
//          backgroundColor: Colors.white,
//          onPressed: () {
//          demofacecontroller.capture();
//        },
//          child:const Icon(Icons.camera,color: Colors.blueGrey,),
//        ),*//*
//      ),*/
//    );
//   }
//
//   void getfirebasedata() async{
//
//     try {
//       modedata dataa =modedata();
//       firebasedatabase.fetchdatabase();
//       dbobj  = FirebaseDatabase.instance.ref().child("Asset").onValue.listen((event) {
//          datalist = event.snapshot.value;
//          datalist.length;
//          Map<dynamic, dynamic> inedxdata = datalist as Map;
//          inedxdata.forEach((key, value) {
//            dataa = modedata();
//            dataa.key = key;
//            Map<dynamic, dynamic> valuedata = value as Map;
//            valuedata.forEach((key, value) {
//              if (key == "texture") {
//                dataa.texture = value;
//              }
//              else {
//                dataa.model = value;
//              }
//              });
//            dat.add(dataa);
//          });
//         print(datalist.length);
//          modeldatacontroller.add(true);
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//     // var data = await dbobj.get();
//     // datalist = data.snap;
//   }
//
// }
//
//
// class modedata{
//   modedata({
//      this.key= "",
//      this.texture= "",
//      this.model= "",
//   });
//   String key ;
//   String texture ;
//   String model ;
// }