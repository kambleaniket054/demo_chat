import 'dart:math';

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
     appBar: AppBar(
       // systemOverlayStyle:
       backgroundColor: Colors.transparent,
       elevation: 0,
       automaticallyImplyLeading: false,
       title: Text("Library",style: TextStyle(
         color: Colors.white,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
     ),
     body:PageView.builder(
       // shrinkWrap: true,
       scrollDirection: Axis.vertical,
         itemCount: 100,
         itemBuilder: (context,index){
       return Container(
         color: Colors.black87/*Colors.primaries[Random().nextInt(Colors.primaries.length)]*/,
       child: Stack(
         children: [
           FutureBuilder(
             future: _initializeVideoPlayerFuture,
               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _controller.play();
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
            bottom: 0,
            child: Column(
              children: [
                Row(
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
                     radius:16,
                     // backgroundImage:NetworkImage(data1.owner.picture))
                     )),
                    SizedBox(width: 18,),
                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                  ],
                ),
                SizedBox(height: 18,),
                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
                SizedBox(height: 8,),
                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
              ],
            ),
          ),
         // backgroundImage:NetworkImage(data1.owner.picture)
         ],
       ),
       );
     }),
   );
  }



}