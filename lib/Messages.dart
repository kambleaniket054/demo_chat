import 'dart:async';

import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import 'ChatScreen.dart';
import 'Model/userdetail.dart';

class messages extends StatefulWidget{
  createState ()=> messagesState();
}

class messagesState extends State<messages> with AutomaticKeepAliveClientMixin<messages>{
  var ref;
  StreamController chatslistcontroller = StreamController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     ref = FirebaseDatabase.instance.reference().child("Userdetails").child(usredetails.uid).once().then((value){
      print("firebasedata: ${value.value}");
      data = value.value['chats'];
      WidgetsBinding.instance?.addPostFrameCallback((_) =>chatslistcontroller.add(true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back,color: Colors.black87,)),
        title:const Text("Messages",style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),),
      ),
      body:Column(
        children: [
          Expanded(
            child: NestedScrollView(
              body: messagesListview(), headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
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
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add_rounded,color: Colors.white,),
      ),
    );
  }

  messagesListview(){
    return StreamBuilder(
      initialData: false,
      stream: chatslistcontroller.stream,
      builder: (context, snapshot) {
        if(snapshot.data == false && snapshot.connectionState == ConnectionState.waiting){
          return Center(child: const CircularProgressIndicator(),);
        }
        return ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            itemBuilder:(context,index){
          return listItem(index);
        }, separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1,indent: 15.0,endIndent: 15.0,);
        },);
      }
    );
  }
  // https://i.redd.it/zbuam1y2pvx21.jpg
  listItem(int index){
    return messagetile(data, index);
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
  @override
  Widget build(BuildContext context) {
   return StreamBuilder<DocumentSnapshot>(
         stream: FirebaseFirestore.instance.collection("1234567890").doc(widget.messagelist[widget.listindex].toString()).snapshots(),
         builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting){
             return Shimmer.fromColors(child: Container(),  baseColor: Colors.grey.shade300,
               highlightColor: Colors.grey.shade100,
               enabled: true,);
           }
           var memberslist = snapshot.data?.get('members');
           var memberid;
           userdetail user = userdetail(name: "", createddate: "", username: "");
           for(int i=0;i<memberslist.length;i++){
             if(memberslist[i] != usredetails.uid){
               memberid = memberslist[i];
             }
           }
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
                    initialData: userdetail(name: "",createddate: "",username: ""),
                      future: getusername(memberid),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Shimmer.fromColors(child: Container(), baseColor: Colors.white, highlightColor: Colors.grey);
                        }
                        user = snapshot.data!;
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.amber,
                              foregroundImage:snapshot.data?.profileimage == null ? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") : NetworkImage(snapshot.data?.profileimage),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding:const  EdgeInsets.only(left: 8,top: 8,bottom: 8,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  createTextThemeWise(snapshot.data!.name.toString(),const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  )),
                                  createTextThemeWise("latest massage display hear", const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black26,
                                  ))
                                ],
                              ),
                            ),
                          ],
                        );

                  }),
                   Spacer(),
                   Container(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         createTextThemeWise("7:55", const TextStyle(color: Colors.black26)),
                         CircleAvatar(
                           radius: 8,
                           backgroundColor: Colors.black54,
                           child: Text("2",style: TextStyle(color: Colors.white,fontSize: 12),),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           );
         }
     );


  }

   Future<userdetail> getusername(String memberid) async {
     userdetail user = userdetail(name: "", createddate: "", username: "");

  await FirebaseDatabase.instance.reference().child("Userdetails").child(memberid).once().then((value){
      print("firebasedata: ${value.value}");

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