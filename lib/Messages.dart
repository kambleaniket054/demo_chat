import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatScreen.dart';

class messages extends StatefulWidget{
  createState ()=> messagesState();
}

class messagesState extends State<messages>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // firestore.collection("/1234567890").get().then((value){
    //
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        elevation: 0  ,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back,color: Colors.black87,)),
        title:const Text("Messages",style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),),
      ),
      body:Column(
        children: [
          messagesListview(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add_rounded,color: Colors.white,),
      ),
    );
  }

  messagesListview(){
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("/1234567890").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // snapshot.data.docs;
            return ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return listItem();
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1, indent: 15.0, endIndent: 15.0,);
              },);
        }
      ),
    );
  }
  // https://i.redd.it/zbuam1y2pvx21.jpg
  listItem(){
    return InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
      },
      child: Container(
        // color: Colors.black54,
        padding:const EdgeInsets.only(left: 20,top: 8,bottom: 8,right: 12),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.amber,
              foregroundImage: NetworkImage(""),
            ),
            const SizedBox(width: 10,),
            Container(
              padding:const  EdgeInsets.only(left: 8,top: 8,bottom: 8,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createTextThemeWise("TOUsername",const TextStyle(
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
}