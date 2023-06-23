import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class librarypage extends StatefulWidget{
  createState()=>librarypagestate();
}
class librarypagestate extends State<librarypage>{
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black87,
            systemNavigationBarDividerColor: Colors.black87,
            systemNavigationBarIconBrightness: Brightness.light,
      ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     extendBody: false,
     backgroundColor: Colors.black87,
     appBar: AppBar(
       // systemOverlayStyle:
       backgroundColor: Colors.transparent,
       flexibleSpace: Container(
       decoration: BoxDecoration(
       gradient: LinearGradient(
       colors: [Colors.black.withOpacity(0.6), Colors.transparent],
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter,
   ),
    ),),
       elevation: 0,
       automaticallyImplyLeading: false,
       title: const Text("Library",style: TextStyle(
         color: Colors.white,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
     ),
     body:PageView.builder(
       onPageChanged: (ind){
         // _controller.pause();
       },
       // shrinkWrap: true,
       scrollDirection: Axis.vertical,
         itemCount: 100,
         itemBuilder: (context,index){
            VideoPlayerController _controller;
            Future<void> _initializeVideoPlayerFuture;
           _controller = VideoPlayerController.network(
             'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
           );
           _initializeVideoPlayerFuture = _controller.initialize();
           _controller.setLooping(true);
           _controller.play();
       return Container(
         // color: Colors.white/*Colors.primaries[Random().nextInt(Colors.primaries.length)]*/,
       child: GestureDetector(
         onTap:(){
           _controller.pause();
         },
         child: Stack(
           children: [
             FutureBuilder(
               future: _initializeVideoPlayerFuture,
                 builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller)),
                    );

                  }
                  else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                 },
             ),
            Positioned(
              // top: MediaQuery.of(context).size.height-150,
              left:15,
              bottom: 20,
              child: Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
         // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
         decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(30),
           //color:color.elementAt(index),
         ),
                         padding: const EdgeInsets.all(8),
                         child:  CircleAvatar(
                         backgroundColor: Colors.orange,
                         radius:18,
                         // backgroundImage:NetworkImage(data1.owner.picture))
                         )),
                        SizedBox(width: 8,),
                        Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: 18,),
                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                    SizedBox(height: 8,),
                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),SizedBox(height: 18,),
                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                    SizedBox(height: 8,),
                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                    SizedBox(height: 8,),
                  ],
                ),
              ),
            ),
             Positioned(
               // top: MediaQuery.of(context).size.height-150,
               right: 20,
               bottom: 20,
               child: Column(
                 children: [
                   // Row(
                   //   crossAxisAlignment: CrossAxisAlignment.center,
                   //   children: [
                   //     Container(
                   //       // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                   //         decoration: BoxDecoration(
                   //           borderRadius: BorderRadius.circular(30),
                   //           //color:color.elementAt(index),
                   //         ),
                   //         padding: const EdgeInsets.all(8),
                   //         child:  CircleAvatar(
                   //           backgroundColor: Colors.orange,
                   //           radius:16,
                   //           // backgroundImage:NetworkImage(data1.owner.picture))
                   //         )),
                   //     SizedBox(width: 8,),
                   //     Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                   //   ],
                   // ),
                   SizedBox(height: 18,),
                   IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.heart,color: Colors.white,),iconSize: 25,),
                   IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.share, color:Colors.white,),iconSize: 25,),
                   IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.bubble_middle_bottom,color: Colors.white,),iconSize: 25,),

                 ],
               ),
             ),
           // backgroundImage:NetworkImage(data1.owner.picture)
           ],
         ),
       ),
       );
     }),
   );
  }



}