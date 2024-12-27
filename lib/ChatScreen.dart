import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/Model/userdetail.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
    ServicesBinding.instance?.keyboard.addHandler(_onkeyclicked);
    // listscrolcontrol.animateTo(100.0, duration: Duration(microseconds: 3), curve:Curves.linear );
  }
  //"https://i.redd.it/zbuam+1y2pvx21.jpg

  @protected
  @mustCallSuper
  void deactivate() { }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colorcode.foreground,
        elevation: 0,
        leadingWidth: 0.0,
        centerTitle: false,
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
                padding: EdgeInsets.all(0),
                child: Icon(Icons.arrow_back,color: Colors.black87,),
              ),
            ),
            SizedBox(width: 10,),
            // IconButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: (){
            //       Navigator.pop(context);
            //     }, icon: const Icon(Icons.arrow_back,color: Colors.black87,)),
             CircleAvatar(
              radius: 24,
              backgroundImage:  NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
              foregroundImage:(widget.user == null || widget.user.profileimage == null) ?  NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"):NetworkImage(widget.user.profileimage.toString()),
            ),
            const SizedBox(width:10),
            createTextThemeWise(widget.user.name.toString(), style: TextStyle(color: Colors.black87,fontSize: 16))
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
               var data = snapshot.data?.data();
                messagedata = data;
               if (snapshot.hasError || messagedata == null && snapshot.connectionState == ConnectionState.active) {
                 return  Center(child: Text('Something went wrong',style:GoogleFonts.roboto(fontSize: 18,color: Colors.black54),));
               }
               if (messagedata != null || messagedata != []) {
                 messagedata = messagedata["messages"].reversed.toList();
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
                  if( messagedata[index]['sender'] == Usersprofile.uid){
                    fromuser = true;
                  }
                 Timestamp timestamp = messagedata[index]['created At']!= null || messagedata[index]['created At'] !=""?messagedata[index]['created At'] as Timestamp : Timestamp.now();
                  DateTime date = timestamp.toDate();
                  return Container(
                    // height: 100,
                    padding: const EdgeInsets.all(18),
                    // decoration: BoxDecoration(
                    //   // color: Colors.red,
                    //   border: Border.all(color: Colors.white54)
                    // ),
                    // alignment:fromuser ? Alignment.centerRight : Alignment.centerLeft,
                    child:fromuser ? SentMessage(message: messagedata[index]['content'].toString(),messagedate:date.minute.toString(),):ReceivedMessage(message: messagedata[index]['content'].toString(),messagedate:date.minute.toString() )/*BubbleSpecialOne(
                      isSender:fromuser,
                      delivered:fromuser ? true:false,
                      text:  messagedata[index]['content'].toString(),),*/
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
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding:  MediaQuery.of(context).viewInsets,
          child: Container(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(24),
            //   color: Colors.white,
            // ),
            margin: const EdgeInsets.only(left: 15,right: 15,),
            padding: const EdgeInsets.only(left: 0,right: 15,top: 5),
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
                    onChanged: (value){
                      print(value.toString());
                    },
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
                      "sender":Usersprofile.uid.toString(),
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
      ),
    );
  }













  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // onkeyclicked(KeyEvent event) {
  //   print(event.toString());
  // }

  bool _onkeyclicked(KeyEvent event) {
    print(event.character);
    print(event.toString());
    return false;
  }
}











class Triangle extends CustomPainter {
  final Color bgColor;

  Triangle(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}






class SentMessage extends StatelessWidget {
  final String message;
  final String messagedate;
  const SentMessage({
     this.message,
     this.messagedate,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(color: Colors.white, fontFamily: 'Monstserrat', fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8,),
                     Text("${messagedate} min ago",style:TextStyle(color: Colors.white54, fontFamily: 'Monstserrat', fontSize: 11)),
                  ],
                )
              ),
            ),

            CustomPaint(painter: Triangle(Colors.grey[800])),
          ],
        ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}







class ReceivedMessage extends StatelessWidget {
  final String message;
  String messagedate;
   ReceivedMessage({
     this.message, this.messagedate,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: Triangle(Colors.grey[300]),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(color: Colors.black, fontFamily: 'Monstserrat',fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8,),
                    Text("${messagedate} min ago",style:TextStyle(color:Colors.black54, fontFamily: 'Monstserrat', fontSize: 11)),
                  ],
                ) /*Text(
                  message,
                  style: TextStyle(color: Colors.black, fontFamily: 'Monstserrat', fontSize: 14),
                )*/,
              ),
            ),
          ],
        ));

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}