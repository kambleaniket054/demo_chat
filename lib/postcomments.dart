import 'dart:async';
import 'dart:collection';

import 'package:demo_chat/custom/ResumableState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Model/commentModel.dart';
import 'Model/instaPostmodel.dart';
import 'Vm/vm_post.dart';
import 'globalfunction.dart';

class postcomments extends StatefulWidget{
  Datum data;
  String id;
  postcomments(this.id,this.data);

  createState() => postcommentsstate();
}

class postcommentsstate extends State<postcomments> with AutomaticKeepAliveClientMixin<postcomments>{
  late Datum data1;
  late String id;
  final vm_post _vmpost = vm_post();
  StreamController<bool> commentstreams = StreamController.broadcast();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     data1 = widget.data;
     id = widget.id;
  }

  @override
  onReady(){
    getcommentslist(id,commentstreams,data1);
    // getcommentslist(id,commentstreams,data1);
  }


  getcommentslist(String id, StreamController<bool> commentstreams, Datum data1) async {
    if (data1.commentlist == null) {
      Map<String,dynamic> commenmap = HashMap();
      commenmap["id"] = id;
      commenmap['commentStream'] = commentstreams;
      commenmap['data1'] = data1;
      await compute(_vmpost.getcommentslist,commenmap) ;
      // print(commentdata);
     // /* var data =  await*/ _vmpost.getcommentslist(commenmap);
      // data1.commentlist = data ?? [];
    }
    // commentstreams.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
          child: createTextThemeWise("Comments", TextStyle(color: Colors.grey)),
        ),

        StreamBuilder<bool>(
          // future: getcommentslist(id),
            stream: commentstreams.stream,
            initialData:true,
            builder: (context,snapshoot){
              CommentModel? data;
              if (snapshoot.data == true) {
                data  =data1.commentlist;
                print(data?.data.length);
                // data1.commentlist = snapshoot.data as CommentModel?;
              }
              return snapshoot.data == true ? Container(
                padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                child: Column(
                  children: List.generate(data!.data.length, (index) => Container(
                      child: Row(
                        children: [
                          Text(data!.data[index].owner.firstName +" "+ data.data[index].owner.lastName,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                          const SizedBox(width: 10,),
                          Flexible(
                            child: Text(data.data[index].message,style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              // overflow: TextOverflow.ellipsis,
                            ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ],
                      )
                    /*  Row(
                  children: [
                    createTextThemeWise("${data!.data[0].owner.firstName}", TextStyle()),
                    createTextThemeWise("${data!.data[0].message}", TextStyle()),
                  ],
                ),*/
                  )),
                ),
              ):const Center(
                  child:CircularProgressIndicator(color: Colors.black38,backgroundColor: Colors.white54,)
              );
            }),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}