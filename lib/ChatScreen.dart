import 'dart:convert';
import 'dart:math';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Colorcode.dart';

class ChatScreen extends StatefulWidget{
  createState()=> chatscreenstate();
}

class chatscreenstate extends State<ChatScreen>{
  ScrollController listscrolcontrol = ScrollController();
  List snapdata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listscrolcontrol.animateTo(100.0, duration: Duration(microseconds: 3), curve:Curves.linear );
  }
  //"https://i.redd.it/zbuam+1y2pvx21.jpg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:Colorcode.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Colorcode.foreground,
        elevation: 0,
        leading: IconButton(
           padding: EdgeInsets.zero,
            onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.black87,)),
        // automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.amber,
              foregroundImage: NetworkImage(""),
            ),
            SizedBox(width:10),
            createTextThemeWise("tousername", const TextStyle(color: Colors.black87,fontSize: 16))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              // initialData: [],
              stream: firestore.collection("/1234567890").doc("Zx5d4ejP6eAJJJmxLhIh").snapshots(),
              builder: (context, snapshot) {
               try {
                 if(snapshot.connectionState == ConnectionState.waiting){
                   return Center(child: CircularProgressIndicator(),);
                 }
                  if (snapshot.connectionState == ConnectionState.active) {
                    snapdata = snapshot.data!.data()['messages'] ;
                  }
                 // print("firestore data------>"+data["messages"]);
               } on Exception catch (e) {
                 // TODO
               }
                return ListView.builder(
                  controller: listscrolcontrol,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                    itemCount: snapdata.length,
                    itemBuilder:(context,index){
                  bool fromuser = false;
                  if(index%2 ==0 ){
                    fromuser = true;
                  }
                  return Container(
                    height: 100,
                    // decoration: BoxDecoration(
                      // color: Colors.red,
                    //   border: Border.all(color: Colors.white54)
                    // ),
                    // alignment:fromuser ? Alignment.centerRight : Alignment.centerLeft,
                    child: BubbleSpecialOne(
                      isSender:fromuser,
                      color: Colorcode.foreground,
                      delivered:fromuser ? true:false,
                      text: snapdata[index]['content'].toString(),),
                  );
                });
              }
            ),
          ),
        ],
      ),
      // persistentFooterButtons: [Container(
      //   child: Row(
      //     children: [
      //       CircleAvatar(
      //         backgroundColor: Colors.amber,
      //         foregroundImage: NetworkImage(""),
      //       ),
      //       Flexible(
      //         child:TextField(
      //           keyboardType: TextInputType.text,
      //           autofillHints: ["Message"],
      //
      //         ),
      //       ),
      //     ],
      //   ),
      // ),],
      bottomNavigationBar: Padding(
        padding:  MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colorcode.foreground,
          ),
          margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          padding: const EdgeInsets.only(left: 8,right: 15,top: 5,bottom: 5),
          child: Row(
            children:  [
              Flexible(
                child:TextField(
                  // expands: true,
                  maxLines: null,
                  // minLines: null,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black54,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    paste: true,
                    selectAll: true,
                  ),
                  style: TextStyle(
                    fontSize: 18
                  ),
                  autocorrect: true,
                  decoration: InputDecoration(
                    fillColor: Colorcode.backgroundcolor,
                    contentPadding: const EdgeInsets.only(left: 8,right:10,top: 8,bottom: 8),
                    hintText: "Message",
                    border: OutlineInputBorder(
                      gapPadding: 18,
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide(
                        color: Colorcode.backgroundcolor
                      ),
                    ),
                    // suffixIcon: IconButton(onPressed: (){},icon:Icon(Icons.attach_file_rounded,color: Colors.black54,))
                  ),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  return;
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  // foregroundImage: NetworkImage(""),
                  child: Icon(Icons.attach_file_rounded,color: Colors.white,),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  // firestore.collection("/1234567890").doc("Zx5d4ejP6eAJJJmxLhIh").set(data)
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  // foregroundImage: NetworkImage(""),
                  child: Icon(Icons.send_rounded,color: Colors.white,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}