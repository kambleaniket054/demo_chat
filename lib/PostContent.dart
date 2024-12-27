import 'dart:convert';
import 'dart:typed_data';

import 'package:demo_chat/Vm/Vm_firebase.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/home_block/homeCubit.dart';
import 'package:demo_chat/home_block/homecubitstate.dart';
import 'package:demo_chat/postcomments.dart';
import 'package:demo_chat/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';

import 'Colorcode.dart';
import 'Model/instaPostmodel.dart';

class PostContent extends StatelessWidget{
  Datum postModel;
  PostContent(this.postModel,);
  final homeC = homeCubit();
  TextEditingController CommentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   var profileimage = postModel.owner !=null ? postModel.owner.picture.toString() :"";
   var firstname =postModel.owner !=null ?  postModel.owner.firstName :"User";
   var lastname = postModel.owner !=null ? postModel.owner.lastName : "";
   return BlocConsumer<homeCubit,homecubitstate>(
       bloc: homeC,
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object state) {
       return Container(
         constraints: const BoxConstraints(minHeight: 395,
         ),
         // color: Colors.yellow,
         //width: MediaQuery.of(context).size.width,height: 450,
         padding: const EdgeInsets.only(bottom: 15),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Row(
               mainAxisAlignment:MainAxisAlignment.start,
               children:  [
                 /* Container(
                           child: Container(
                  margin: const EdgeInsets.only(left:10,right: 10,top: 0,bottom: 10),
                    decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:Colors.yellow,
                    ),
                   // padding: EdgeInsets.all(3),
                    child:  Image.network("https://i.stack.imgur.com/l60Hf.png",width: 16,height: 16,)),
                         ),*/
                 Container(
                   padding: const  EdgeInsets.symmetric(
                     vertical: 8,
                     horizontal: 8,
                   ).copyWith(right: 0),
                   child:  Row(
                     children: [
                      /* CachedNetworkImage(
                         imageUrl: data1.owner.picture,
                         useOldImageOnUrlChange:true,
                         imageBuilder: (context,im){
                           return CircleAvatar(
                             radius:26,
                             backgroundImage:im,
                           );
                         },// cacheManager: ,
                         // progressIndicatorBuilder: (context, url, downloadProgress) =>
                         //     Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.black38,backgroundColor: Colors.white54,)),
                         errorWidget: (context, url, error) => const Icon(Icons.error),
                       ),*/
                     CircleAvatar(
                     radius: 18,
                     backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") ,
                     foregroundImage:NetworkImage(profileimage),
                   ),
                       /*CircleAvatar(
                                 radius:16,
                                 backgroundImage:NetworkImage(data1.owner.picture),
                               ),*/
                       const SizedBox(width: 5,),
                       Text(firstname +" "+ lastname,style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 14,
                       ),),
                     ],
                   ),
                 ),
               ],
             ),
             Stack(
               alignment: Alignment.center,
               children: [
                 Container(
                   // height: MediaQuery.of(context).size.height * 0.35,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         color: Colors.grey.shade100,
                         backgroundBlendMode: BlendMode.color
                     ),
                     //color:Colors.red,
                     child: /*CachedNetworkImage(
                       imageUrl: data1.image,
                       useOldImageOnUrlChange:true,
                       // cacheManager: ,
                       progressIndicatorBuilder: (context, url, downloadProgress) =>
                           Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.black38,backgroundColor: Colors.white54,)),
                       errorWidget: (context, url, error) => const Icon(Icons.error),
                     )*/
                     postModel.isfirebase == true ? Image.memory(base64Decode(postModel.image),gaplessPlayback: true,):
                     Image.network(postModel.image.toString()),
                   // Image.network(data1.image,fit:BoxFit.cover,isAntiAlias:true,scale:1,filterQuality: FilterQuality.high),
                 ),
               ],
             ),
             Row(
               children: [
                 IconButton(onPressed: (){
                   homeC.onlikedbuttonclicked();
                 }, icon:Icon(state.runtimeType == onlikebuttonclicked ? CupertinoIcons.heart_solid:CupertinoIcons.heart,color: state.runtimeType == onlikebuttonclicked ? Colors.red:Colors.black87,),iconSize: 25,),
                 IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.share),iconSize: 25,),
                 IconButton(onPressed: (){
                   showcommentBottomsheet(context,postModel.commentlist);
                 }, icon:const Icon(CupertinoIcons.bubble_middle_bottom),iconSize: 25,),
               ],
             ),
             Container(
               padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
               child: Column(
                 children: [
                   Row(
                     children: [
                       Text(postModel.likes.toString() +" Likes",style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 14,
                       ),),
                     ],
                   )
                 ],
               ),
             ),
             Container(
               padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
               child: Column(
                 children: [
                   Row(
                     children: [
                       Text(firstname +" "+ lastname,style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 16,
                       ),),
                       const SizedBox(width: 10,),
                       Flexible(
                         child: Text(postModel.text,style: const TextStyle(
                           fontWeight: FontWeight.normal,
                           fontSize: 16,
                           // overflow: TextOverflow.ellipsis,
                         ),
                           overflow: TextOverflow.ellipsis,
                           softWrap: false,
                         ),
                       ),
                     ],
                   )
                 ],
               ),
             ),
             postcomments(postModel.id,postModel,'post'),
             // getcomments(data1.id,data1),
           ],
         ),
       );
     }
   );
  }

  void showcommentBottomsheet(BuildContext context,var commentlist) {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        constraints: BoxConstraints(
          minHeight: 180,
          maxHeight: MediaQuery.of(context).size.height
        ),
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20)),
        ),
        builder: (context){
      return SafeArea(
        bottom: true,
        top: true,
        // minimum: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
        // maintainBottomViewPadding: true,
        child: Container(
          padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
             const Divider(color: Colors.black54,thickness: 4,endIndent: 150,indent: 150,),
              postcomments(postModel.id,postModel,'bottomcomment'),
              Container(
                // height: 50,
                margin: const EdgeInsets.only(left: 12,right: 12,bottom: 10),
                padding: const EdgeInsets.only(left: 6,right: 6),
                // color: Colors.red,
                child: Row(
                  children: [
                    const SizedBox(width: 8,),
                    Flexible(
                     flex : 4,
                      child: TextField(
                        controller:CommentController,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        // maxLength: null,
                        style: TextStyle(),
                          autocorrect: true,
                          decoration: InputDecoration(
                            fillColor: Colorcode.backgroundcolor,
                            contentPadding: const EdgeInsets.only(left: 8,right:10,top: 8,bottom: 8),
                            hintText: "Comment",
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
                    const SizedBox(width: 8,),
                    InkWell(
                      onTap: (){
                        // Vm_firebase()
                        Map<String, dynamic> submap = {
                          "id" : Usersprofile.uid.toString(),
                          "message" : CommentController.text,
                          "owner":Owner(
                            id : Usersprofile.uid.toString() ,
                            firstName:Usersprofile.displayName,
                            lastName : "",
                            picture:Usersprofile.photoURL,
                          ),
                          "post" : '',
                          "publishDate":DateTime.now() ,
                        };
                        // Map<String, dynamic> messagedata = {"data":FieldValue.arrayUnion([submap])};
                         Map<String, dynamic> comment = {"comment":FieldValue.arrayUnion([submap])};
                        // FieldValue.arrayUnion(["greater_virginia"]
                        FirebaseFirestore.instance.collection("12345678").doc(postModel.postid.toString()).update(comment).then((value){
                        });
                        },
                      child: Container(
                        child: const Icon(Icons.send,color: Colors.black87,size: 25,),
                      ),
                    ),
                    const SizedBox(width: 8,),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}