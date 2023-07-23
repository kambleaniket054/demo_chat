import 'dart:math';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{
  createState()=> chatscreenstate();
}

class chatscreenstate extends State<ChatScreen>{
  ScrollController listscrolcontrol = ScrollController();
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            child: ListView.builder(
              controller: listscrolcontrol,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                itemCount: 100,
                itemBuilder:(context,index){
              bool fromuser = false;
              if(index%2 ==0 ){
                fromuser = true;
              }
              return Container(
                height: 100,
                // decoration: BoxDecoration(
                //   // color: Colors.red,
                //   border: Border.all(color: Colors.white54)
                // ),
                // alignment:fromuser ? Alignment.centerRight : Alignment.centerLeft,
                child: BubbleSpecialOne(
                  isSender:fromuser,
                  delivered:fromuser ? true:false,
                  text: index.toString(),),
              );
            }),
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
            color: Colors.grey[300]
          ),
          margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
          padding: EdgeInsets.only(left: 0,right: 15,top: 5,bottom: 5),
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
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 8,right:10,top: 8,bottom: 8),
                    hintText: "Message",
                    border: OutlineInputBorder(
                      gapPadding: 18,
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide(
                        color: Colors.white54
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
                  return;
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  // foregroundImage: NetworkImage(""),
                  child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}