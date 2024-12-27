import 'dart:async';

import 'package:demo_chat/MessageBloc/cubitstate.dart';
import 'package:demo_chat/MessageBloc/messageController.dart';
import 'package:demo_chat/MessageBloc/messageEvent.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/serchdetail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'ChatScreen.dart';
import 'MessageBloc/messageCubit.dart';
import 'MessageBloc/messageState.dart';
import 'Model/userdetail.dart';

class messages extends StatefulWidget{
  createState ()=> messagesState();
}

class messagesState extends State<messages> with AutomaticKeepAliveClientMixin<messages>{
  var ref;
  StreamController chatslistcontroller = StreamController();
  messageController msgcontroller = messageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msgcontroller.add(messagfetchEvent());
    // var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(Usersprofile.uid).once().then((value){
    //   print("firebasedata: ${value.value}");
    //   data = value.value['chats'];
    //   WidgetsBinding.instance?.addPostFrameCallback((_) =>chatslistcontroller.add(true));
    // });
  }
 GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: true,
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon:const Icon(Icons.arrow_back,color: Colors.black87,)),
        title:const Text("Messages",style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
            textScaleFactor: 1.0,
        ),
      ),
      body:Column(
        children: [
          Expanded(
            child: NestedScrollView(
              body: messagesListview(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                return [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    // leadingWidth:MediaQuery.of(context).size.width,
                    expandedHeight: 50,
                    title:Container(
                      // width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10,bottom: 10,right: 12,left: 12),
                      child:  const TextField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        decoration: InputDecoration(
                            hintText: "Search",
                            contentPadding: EdgeInsets.only(top:8,left: 10,right: 10,bottom: 8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                ];
            }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>serchdetail(fromscreen: "message",))).then((value){
          msgcontroller.add(messagfetchEvent());
        });
      },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add_rounded,color: Colors.white,),
      ),
    );
  }

  messagesListview(){
    return BlocConsumer<messageController,messageState>(
      bloc:msgcontroller,
      builder:(context,state) {
        if (state is messageloading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else if (state is messagelistfetched) {
          final msglist = state.msgList ?? [];
          return ListView.builder(
            itemCount: msglist.length ?? 0,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              if(msglist[index] == ""){
               return Container();
              }
              else {
                return messagetile(
                    msglist, index) /*listItem(index,msglist.msgList)*/;
              }
            },
           /* separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1, indent: 15.0, endIndent: 15.0,);
            },*/);
        }else{
          return Center(child: createTextThemeWise("NO Data Avaliable",style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          )),);
        }
      },
      listener: (BuildContext context, Object state) {  },
    );

    /*StreamBuilder(
      initialData: false,
      stream: chatslistcontroller.stream,
      builder: (context, snapshot) {

      }
    );*/
  }
  // https://i.redd.it/zbuam1y2pvx21.jpg
  listItem(int index, List msgList){
    return messagetile(msgList, index);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}



class messagetile extends StatefulWidget{
  List messagelist = [];
  int listindex = 0;
  messagetile(this.messagelist,this.listindex);

  @override
  State<messagetile> createState() => _messagetileState();
}

class _messagetileState extends State<messagetile> with AutomaticKeepAliveClientMixin<messagetile> {
  var messagefirebasestream;
  final msgcubit = messageCubit();
  var memberslist;
  userdetail user = userdetail();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msgcubit.fetchmessagedetails(widget.messagelist[widget.listindex]);
    // messagefirebasestream = widget.messagelist[widget.listindex]  != "" ?  FirebaseFirestore.instance.collection("1234567890").doc(widget.messagelist[widget.listindex].toString()).snapshots(): StreamController();

  }

  @override
  Widget build(BuildContext context) {
   return StreamBuilder<cubitstate>(
         stream:msgcubit.stream/* FirebaseFirestore.instance.collection("1234567890").doc(widget.messagelist[widget.listindex].toString()).snapshots()*/,
         builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting && snapshot.data is cubitloadingState){
             return Shimmer.fromColors(child: Container(),  baseColor: Colors.grey.shade300,
               highlightColor: Colors.grey.shade100,
               enabled: true,);
           }
           else if(snapshot.data is cubitloadfailstate){
             return const Center(child: Text("Trouble geting Data"),);
           }
            else if(snapshot.data is cubitdatareceived){
              memberslist ??= snapshot.data as cubitdatareceived;
              var memberid = memberslist.memberID;
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(widget.messagelist[widget.listindex].toString(),user)));
                },
                child: Container(
                  // color: Colors.black54,
                  padding:const EdgeInsets.only(left: 20,top: 8,bottom: 8,right: 12),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<userdetail>(
                          future: getusername(memberid),
                          builder: (context,snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting && user.createddate != ""){
                              return Shimmer.fromColors(child: Container(), baseColor: Colors.white, highlightColor: Colors.grey);
                            }
                            user = snapshot.data;
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.amber,
                                  foregroundImage:snapshot.data.profileimage == null || snapshot.data.profileimage == "null"? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") : NetworkImage(snapshot.data?.profileimage),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  padding:const  EdgeInsets.only(left: 8,top: 8,bottom: 8,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      createTextThemeWise(snapshot.data.name.toString(),style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      )),
                                      // createTextThemeWise("latest massage display hear", const TextStyle(
                                      //   fontSize: 14,
                                      //   color: Colors.black26,
                                      // ))
                                    ],
                                  ),
                                ),
                              ],
                            );

                          }),
                      Spacer(),
                      // Container(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       createTextThemeWise("7:55", const TextStyle(color: Colors.black26)),
                      //       CircleAvatar(
                      //         radius: 8,
                      //         backgroundColor: Colors.black54,
                      //         child: Text("2",style: TextStyle(color: Colors.white,fontSize: 12),),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }
            else{
              return const Center(child: Text("Trouble geting Data"),);
            }
         }
     );


  }

   Future<userdetail> getusername(String memberid) async {
     userdetail user = userdetail(name: "", createddate: "", username: "");

  await FirebaseDatabase.instance.reference().child("Userdetails").child(memberid).once().then((value){
      // print("firebasedata: ${value.value}");
      user.name = value.value['username'];
      user.profileimage = value.value['photourl'];
      // WidgetsBinding.instance?.addPostFrameCallback((_) =>chatslistcontroller.add(true));
    }).onError((error, stackTrace)  {
    });
    return user;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}