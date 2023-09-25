import 'package:demo_chat/postcomments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'Model/instaPostmodel.dart';

class PostContent extends StatelessWidget{
  Datum data1;
  PostContent(this.data1,);
  @override
  Widget build(BuildContext context) {
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
                 radius:26,
                 backgroundImage:NetworkImage(data1.owner.picture.toString()),
               ),
                   /*CircleAvatar(
                             radius:16,
                             backgroundImage:NetworkImage(data1.owner.picture),
                           ),*/
                   const SizedBox(width: 5,),
                   Text(data1.owner.firstName +" "+ data1.owner.lastName,style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 18,
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
                 )*/Image.network(data1.image.toString()),
               // Image.network(data1.image,fit:BoxFit.cover,isAntiAlias:true,scale:1,filterQuality: FilterQuality.high),
             ),
           ],
         ),
         Row(
           children: [
             IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.heart),iconSize: 25,),
             IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.share),iconSize: 25,),
             IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.bubble_middle_bottom),iconSize: 25,),
           ],
         ),
         Container(
           padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
           child: Column(
             children: [
               Row(
                 children: [
                   Text(data1.likes.toString() +" Likes",style: const TextStyle(
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
                   Text(data1.owner.firstName +" "+ data1.owner.lastName,style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                   ),),
                   const SizedBox(width: 10,),
                   Flexible(
                     child: Text(data1.text,style: const TextStyle(
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
         postcomments(data1.id,data1),
         // getcomments(data1.id,data1),
       ],
     ),
   );
  }

}