import 'dart:convert';
import 'dart:math';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:demo_chat/Model/userdetail.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Colorcode.dart';

class ChatScreen extends StatefulWidget{
  String chatcode;
  userdetail user;
  ChatScreen(this.chatcode,this.user);

  createState()=> chatscreenstate();
}

class chatscreenstate extends State<ChatScreen> with AutomaticKeepAliveClientMixin<ChatScreen>{
  ScrollController listscrolcontrol = ScrollController();
  List snapdata = [];
  var messagedata;
  TextEditingController Messagecontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // listscrolcontrol.animateTo(100.0, duration: Duration(microseconds: 3), curve:Curves.linear );
  }
  //"https://i.redd.it/zbuam+1y2pvx21.jpg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colorcode.foreground,
        elevation: 0,
        // leading: IconButton(
        //    padding: EdgeInsets.zero,
        //     onPressed: (){
        //      Navigator.pop(context);
        //     }, icon: const Icon(Icons.arrow_back,color: Colors.black87,)),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back,color: Colors.black87,),
              ),
            ),
            // IconButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: (){
            //       Navigator.pop(context);
            //     }, icon: const Icon(Icons.arrow_back,color: Colors.black87,)),
             CircleAvatar(
              radius: 24,
              backgroundColor: Colors.amber,
              foregroundImage:(widget.user == null || widget.user.profileimage == null) ? const NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"):NetworkImage(widget.user.profileimage.toString()),
            ),
            const SizedBox(width:10),
            createTextThemeWise(widget.user.name, const TextStyle(color: Colors.black87,fontSize: 16))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              // initialData:
              stream:FirebaseFirestore.instance.collection("1234567890").doc(widget.chatcode.toString()).snapshots(),
              builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting && messagedata ==null) {
                 return const Center(child: CircularProgressIndicator());
                }
                messagedata = snapshot.data?.data()['messages'];
               if (snapshot.hasError || messagedata == null && snapshot.connectionState == ConnectionState.active) {
                 return  Center(child: Text('Something went wrong',style:GoogleFonts.roboto(fontSize: 18,color: Colors.black54),));
               }
               if (messagedata != null || messagedata != []) {
                 messagedata = messagedata.reversed.toList();
               }
               else{
                 messagedata = [];
               }
                return ListView.builder(
                  reverse: true,
                  controller: listscrolcontrol,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                    itemCount: messagedata?.length,
                    itemBuilder:(context,index){
                  bool fromuser = false;
                  if( messagedata![index]['sender'] == usredetails.uid){
                    fromuser = true;
                  }
                  return Container(
                    height: 100,
                    padding: EdgeInsets.all(18),
                    // decoration: BoxDecoration(
                    //   // color: Colors.red,
                    //   border: Border.all(color: Colors.white54)
                    // ),
                    // alignment:fromuser ? Alignment.centerRight : Alignment.centerLeft,
                    child: BubbleSpecialOne(
                      isSender:fromuser,
                      delivered:fromuser ? true:false,
                      text:  messagedata[index]['content'].toString(),),
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
            color: Colors.transparent,
          ),
          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
          padding: const EdgeInsets.only(left: 0,right: 15,top: 5,bottom: 5),
          child: Row(
            children:  [
              Flexible(
                child:TextField(
                  // expands: true,
                  maxLines: null,
                  // minLines: null,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black54,
                  controller:Messagecontroller,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    paste: true,
                    selectAll: true,
                  ),
                  style:GoogleFonts.roboto(fontSize: 18,color: Colors.black54),
                  autocorrect: true,
                  decoration: InputDecoration(
                    fillColor: Colorcode.backgroundcolor,
                    contentPadding: const EdgeInsets.only(left: 8,right:10,top: 8,bottom: 8),
                    hintText: "Message",
                    border: OutlineInputBorder(
                      gapPadding: 18,
                      borderRadius: BorderRadius.circular(24.0),
                      // borderSide: const BorderSide(
                      //   color: Colors.white54
                      borderSide: BorderSide(
                        color: Colorcode.backgroundcolor
                      ),
                    ),
                    // suffixIcon: IconButton(onPressed: (){},icon:Icon(Icons.attach_file_rounded,color: Colors.black54,))
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  return;
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black87,
                  // foregroundImage: NetworkImage(""),
                  child: Icon(Icons.attach_file_rounded,color: Colors.white,),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Map<String, dynamic> submap = {
                    "content": Messagecontroller.text,
                    "created At":Timestamp.now(),
                    "sender":usredetails.uid.toString(),
                  };

                  Map<String, dynamic> messagedata = {"messages":FieldValue.arrayUnion([submap])};
                  // FieldValue.arrayUnion(["greater_virginia"]
                  FirebaseFirestore.instance.collection("1234567890").doc(widget.chatcode.toString()).update(messagedata).then((value){
                    print("success");
                    Messagecontroller.clear();
                  }).onError((error, stackTrace){
                     print(error.toString());
                  });
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}