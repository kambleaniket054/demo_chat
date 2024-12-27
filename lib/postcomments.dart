import 'dart:async';
import 'dart:collection';

import 'package:demo_chat/custom/ResumableState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Model/commentModel.dart';
import 'Model/instaPostmodel.dart';
import 'ProfileView.dart';
import 'Vm/vm_post.dart';
import 'globalfunction.dart';

class postcomments extends StatefulWidget{
  Datum PostModel;
  String id;
  String fromscreen;
  postcomments(this.id,this.PostModel,this.fromscreen);

  createState() => postcommentsstate();
}

class postcommentsstate extends State<postcomments> with AutomaticKeepAliveClientMixin<postcomments>{
   Datum Postmainmodel;
   String id;
  final vm_post _vmpost = vm_post();
  StreamController<bool> commentstreams = StreamController.broadcast();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Postmainmodel = widget.PostModel;
     id = widget.id;
    getcommentslist(id,commentstreams,Postmainmodel);
  }




  getcommentslist(String id, StreamController<bool> commentstreams, Datum postmodel) async {
    if (postmodel.commentlist == null) {
      Map<String,dynamic> commenmap = HashMap();
      commenmap["id"] = id;
      commenmap['commentStream'] = commentstreams;
      commenmap['data1'] = postmodel;
       _vmpost.getcommentslist(commenmap);
    }
    else{
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        commentstreams.add(true);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget body() {
    switch(widget.fromscreen){
      case 'post':
        return postcommentlist();
      case 'bottomcomment':
        return bottomcommentlist();
      default:
        return Container();
    }
  }

  Widget postcommentlist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
          child: createTextThemeWise("Comments",style: TextStyle(color: Colors.grey)),
        ),

        StreamBuilder<bool>(
          // future: getcommentslist(id),
            stream: commentstreams.stream,
            initialData:false,
            builder: (context,snapshoot){
              CommentModel data;
              if (snapshoot.data == true) {
                data = Postmainmodel.commentlist ?? CommentModel(data: []);
                // print(data?.data.length);
                // data1.commentlist = snapshoot.data as CommentModel?;
              }
              return snapshoot.data == true ? ShaderMask(
                shaderCallback: (Rect rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                    stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child:Container(
                  padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                  child: Column(
                    children: List.generate(data.data.length >4 ?4:data.data.length, (index) => Container(
                        child: Row(
                          children: [
                            Text(data.data[index].owner.firstName +" "+ data.data[index].owner.lastName,style: const TextStyle(
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
                ),
              ): Container(
                padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                child: Column(
                  children: List.generate(3, (index) => Container(
                      child: Row(
                        children: [
                          Container(color: Colors.grey,),
                          SizedBox(width: 10,),
                          Flexible(
                              child:  Container(color: Colors.grey,)
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
              );
            }),
      ],
    );
  }

  Widget bottomcommentlist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
          child: createTextThemeWise("Comments",style: TextStyle(color: Colors.grey)),
        ),

        StreamBuilder<bool>(
          // future: getcommentslist(id),
            stream: commentstreams.stream,
            initialData:false,
            builder: (context,snapshoot){
              CommentModel data;
              if (snapshoot.data == true) {
                data = Postmainmodel.commentlist ?? CommentModel(data: []);
                // print(data?.data.length);
                // data1.commentlist = snapshoot.data as CommentModel?;
              }
              return snapshoot.data == true ? Container(
                padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                child: Column(
                  children: List.generate(data.data.length, (index) => Container(
                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: NetworkImage(data.data[index].owner.picture),
                            backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>profileView(isuser: false,userInfo:data.data[index].owner,fromScreen: "bottomcomment",)));
                                    },
                                  child: Text(data.data[index].owner.firstName +" "+ data.data[index].owner.lastName,style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),),
                                ),
                                // const SizedBox(height: 6,),
                                Text(data.data[index].message,style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ],
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
              ): Container(
                padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                child: Column(
                  children: List.generate(3, (index) => Container(
                      child: Row(
                        children: [
                          Container(color: Colors.grey,),
                          const SizedBox(width: 10,),
                          Flexible(
                              child:  Container(color: Colors.grey,)
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
              );
            }),
      ],
    );
  }

}