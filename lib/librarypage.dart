import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'Colorcode.dart';

class librarypage extends StatefulWidget{
  createState()=>librarypagestate();
}
class librarypagestate extends State<librarypage>{
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  ChewieController? _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /* _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
     _controller.initialize();
    // _controller.setLooping(true);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      showControls: false,
      looping: true,
    );*/
    initializePlayer();
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
    _chewieController!.dispose();
  }
  Future initializePlayer() async {
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    await Future.wait([_controller.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
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
       title:  Text("Library",style: TextStyle(
         color: Colorcode.foreground,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
     ),
     body:Stack(
       fit: StackFit.expand,
       children: [
         _chewieController != null &&
             _chewieController!.videoPlayerController.value.isInitialized
             ? GestureDetector(
           onDoubleTap: () {
             // setState(() {
             //   _liked = !_liked;
             // });
           },
           child: Chewie(
             controller: _chewieController!,
           ),
         )
             : Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             CircularProgressIndicator(),
             SizedBox(height: 10),
             Text('Loading...')
           ],
         ),
         /*if (_liked)
           Center(
             child: LikeIcon(),
           ),*/
         OptionsScreen()
       ],
     ),
     // body:PageView.builder(
     //   onPageChanged: (ind){
     //     // _controller.pause();
     //     _controller.dispose();
     //   },
     //   // shrinkWrap: true,
     //   scrollDirection: Axis.vertical,
     //     itemCount: 100,
     //     itemBuilder: (context,index){
     //        // VideoPlayerController _controller;
     //        Future<void> _initializeVideoPlayerFuture;
     //       _controller = VideoPlayerController.network(
     //         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
     //       );
     //       _initializeVideoPlayerFuture = _controller.initialize();
     //       _controller.setLooping(true);
     //       _controller.play();
     //   return Container(
     //     // color: Colors.white/*Colors.primaries[Random().nextInt(Colors.primaries.length)]*/,
     //   child: GestureDetector(
     //     onTap:(){
     //       _controller.pause();
     //       _controller.dispose();
     //     },
     //     child: Stack(
     //       children: [
     //         FutureBuilder(
     //           future: _initializeVideoPlayerFuture,
     //             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
     //              if (snapshot.connectionState == ConnectionState.done) {
     //                return Center(
     //                  child: Expanded(child: VideoPlayer(_controller)),
     //                );
     //
     //              }
     //              else{
     //                return const Center(
     //                  child: CircularProgressIndicator(),
     //                );
     //              }
     //             },
     //         ),
     //        Positioned(
     //          // top: MediaQuery.of(context).size.height-150,
     //          left:15,
     //          bottom: 20,
     //          child: Container(
     //            // color: Colors.red,
     //            child: Column(
     //              children: [
     //                Row(
     //                  crossAxisAlignment: CrossAxisAlignment.center,
     //                  children: [
     //                    Container(
     //     // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
     //     decoration: BoxDecoration(
     //     borderRadius: BorderRadius.circular(30),
     //       //color:color.elementAt(index),
     //     ),
     //                     padding: const EdgeInsets.all(8),
     //                     child:  CircleAvatar(
     //                     backgroundColor: Colors.orange,
     //                     radius:18,
     //                     // backgroundImage:NetworkImage(data1.owner.picture))
     //                     )),
     //                    SizedBox(width: 8,),
     //                    Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
     //                  ],
     //                ),
     //                SizedBox(height: 18,),
     //                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
     //                SizedBox(height: 8,),
     //                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),SizedBox(height: 18,),
     //                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
     //                SizedBox(height: 8,),
     //                Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
     //                SizedBox(height: 8,),
     //              ],
     //            ),
     //          ),
     //        ),
     //         Positioned(
     //           // top: MediaQuery.of(context).size.height-150,
     //           right: 20,
     //           bottom: 20,
     //           child: Column(
     //             children: [
     //               // Row(
     //               //   crossAxisAlignment: CrossAxisAlignment.center,
     //               //   children: [
     //               //     Container(
     //               //       // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
     //               //         decoration: BoxDecoration(
     //               //           borderRadius: BorderRadius.circular(30),
     //               //           //color:color.elementAt(index),
     //               //         ),
     //               //         padding: const EdgeInsets.all(8),
     //               //         child:  CircleAvatar(
     //               //           backgroundColor: Colors.orange,
     //               //           radius:16,
     //               //           // backgroundImage:NetworkImage(data1.owner.picture))
     //               //         )),
     //               //     SizedBox(width: 8,),
     //               //     Text("username user",style: TextStyle(color:Colors.white,fontSize: 14),),
     //               //   ],
     //               // ),
     //               SizedBox(height: 18,),
     //               IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.heart,color: Colors.white,),iconSize: 25,),
     //               IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.share, color:Colors.white,),iconSize: 25,),
     //               IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.bubble_middle_bottom,color: Colors.white,),iconSize: 25,),
     //
     //             ],
     //           ),
     //         ),
     //       // backgroundImage:NetworkImage(data1.owner.picture)
     //       ],
     //     ),
     //   ),
     //   );
     // }),
   );
  }








/*  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src!);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return*/



}













class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 110),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person, size: 18),
                        radius: 16,
                      ),
                      SizedBox(width: 6),
                      Text('flutter_developer02',style: TextStyle(
                        color: Colorcode.foreground,
                      )),
                      SizedBox(width: 10),
                      Icon(Icons.verified, size: 15),
                      SizedBox(width: 6),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colorcode.foreground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 6),
                  Text('Flutter is beautiful and fast 💙❤💛 ..',style: TextStyle(
                    color:Colorcode.foreground,
                  )),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 15,
                        color:Colorcode.foreground
                      ),
                      Text('Original Audio - some music track--',style: TextStyle(
                        color: Colorcode.foreground,
                      )),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite_outline,color: Colorcode.foreground,),
                  Text('601k',style: TextStyle(color: Colorcode.foreground),),
                  SizedBox(height: 20),
                  Icon(Icons.comment_rounded,color:Colorcode.foreground),
                  Text('1123',style: TextStyle(color: Colorcode.foreground)),
                  SizedBox(height: 20),
                  Transform(
                    transform: Matrix4.rotationZ(5.8),
                    child: Icon(Icons.send,color:Colorcode.foreground),
                  ),
                  const SizedBox(height: 50),
                  Icon(Icons.more_vert,color: Colorcode.foreground,),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}