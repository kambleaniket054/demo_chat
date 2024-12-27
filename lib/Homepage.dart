import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/Messages.dart';
import 'package:demo_chat/Model/commentModel.dart';
import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/home_block/HomeState.dart';
import 'package:demo_chat/home_block/home_block_control.dart';
import 'package:demo_chat/storyview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Colorcode.dart';
import 'PostContent.dart';
import 'home_block/HomeEvents.dart';
HomeBlockControl homeBloc = HomeBlockControl();
class homepage extends StatefulWidget{
  createState() => homepagestate();  
}
class homepagestate extends State<homepage> with AutomaticKeepAliveClientMixin<homepage>{
vm_post _vmpost = vm_post();
bool firscall = false;

StreamController<bool> commentstreams = StreamController<bool>.broadcast();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (postdata1.isEmpty) {
      // loadAd();
      // postdata1.insert(0, null);
    firscall = true;
      homeBloc.add(homefetchevent());
      // _vmpost.getpost();
    // getdata();
    // }
  }




// NativeAd _nativeAd;
bool _nativeAdIsLoaded = false;
StreamController<bool> adStream = StreamController<bool>.broadcast();

// TODO: replace this test ad unit with your own ad unit.
final String _adUnitId = Platform.isAndroid ? 'ca-app-pub-8163017714038102/5158271995':'ca-app-pub-8163017714038102/2840249310';

/// Loads a native ad.
//   void loadAd() {
//   _nativeAd = NativeAd(
//       adUnitId: _adUnitId,
//       // Factory ID registered by your native ad factory implementation.
//       factoryId: Platform.isAndroid ? 'listTile':'nativeadFactory',
//       listener: NativeAdListener(
//         onAdLoaded: (ad) {
//           print('$NativeAd loaded.');
//             _nativeAdIsLoaded = true;
//           // Future.delayed(Duration(seconds:3),(){
//             adStream.add(true);
//           // });
//
//
//         },
//         onAdFailedToLoad: (ad, error) {
//           // Dispose the ad here to free resources.
//           print('$NativeAd failedToLoad: $error');
//           adStream.add(false);
//           ad.dispose();
//         },
//       ),
//       request: const AdRequest(),
//       // Optional: Pass custom options to your native ad factory implementation.
//       // customOptions: {'custom-option-1', 'custom-value-1'}
//   );
//   _nativeAd?.load();
// }



  @override
  Widget build(BuildContext context) {
    if (postdata1.isEmpty && !firscall) {
    // loadAd();
    // postdata1.insert(0, null);
    homeBloc.add(homefetchevent());
    // _vmpost.getpost();
    // getdata();
    }
   return Scaffold(
     resizeToAvoidBottomInset: false,
     backgroundColor: Colors.white,
     body: BlocConsumer<HomeBlockControl,homestate>(
       bloc: homeBloc,
       listenWhen:(current,previous)=>current is homeevent,
       buildWhen: (current,previous)=>current is homestate,
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object state) {
          switch(state.runtimeType){
            case Homeloadingstate:
              return NestedScrollView(
                  headerSliverBuilder:(context,index){
                    return [SliverAppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.white,
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.white,
                      pinned: true,
                      elevation:index == 0 ?0:2,
                      automaticallyImplyLeading: false,
                      title: const Text("Home",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                          textScaleFactor: 1.0,
                      ),
                      actions: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
                        }, icon:const Icon(Icons.add_circle_outline, color: Colors.black87,)),
                        SizedBox(width: 20,),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
                        }, icon:const Icon(Icons.message_outlined, color: Colors.black87,))
                      ],
                    )];
                  } ,
                  body:Container(
                    child: ListView.builder(
                      //physics: const NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: 10,
                      primary: false,
                      itemBuilder: (context,index){
                        // Datum data1;
                        // data1 = postdata1[index];

                        return Container(
                          constraints: const BoxConstraints(minHeight: 300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                children:  [
                                  Container(
                                    padding: const  EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    child:  Row(
                                      children: [
                                        CircleAvatar(
                                          radius:16,
                                          backgroundColor: Colorcode.backgroundcolor,
                                        ),
                                        const SizedBox(width: 5,),
                                        Container(width: 120,height: 20,color: Colorcode.backgroundcolor,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height:175,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colorcode.backgroundcolor,
                                        backgroundBlendMode: BlendMode.color
                                    ),
                                    //color:Colors.red,

                                    // Image.network(data1.image,fit:BoxFit.cover,isAntiAlias:true,scale:1,filterQuality: FilterQuality.high),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
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
                                        Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
                                        const SizedBox(width: 10,),
                                        Flexible(
                                          child:Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },),
                  ),

                );

              break;
            case HomeDatareceivedsuccess:
              return NestedScrollView(
                  headerSliverBuilder:(context,index){
                    return [SliverAppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.white,
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.white,
                      pinned: true,
                      elevation:index == 0 ?0:2,
                      automaticallyImplyLeading: false,
                      leadingWidth: 0.0,
                      centerTitle: false,
                      title: const Text("Home",style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textScaleFactor: 0.9,
                      ),
                      actions: [
                        IconButton(onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
                        }, icon:const Icon(Icons.add_circle_outline, color: Colors.black87,),
                        splashRadius: 4,
                        ),
                        SizedBox(width: 5,),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
                        }, icon:const Icon(Icons.message_outlined, color: Colors.black87,),
                          splashRadius: 4,
                        )
                      ],
                    )];
                  } ,
                  body: GestureDetector(
                    onHorizontalDragStart: (details){
                      if(details.globalPosition.dx <= 30.5){
/*
Navigator.of(mainnavigationkey.currentContext!).push(PageRouteBuilder(
                   opaque: true,
                   transitionDuration: const Duration(milliseconds: 10),
                   pageBuilder: (BuildContext context, _, __) {
                     return new arfilterscreen();
                   },
                   transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                     return SlideTransition(
                       child: child,
                       position:  Tween<Offset>(
                         begin:  Offset(details.globalPosition.dx, details.globalPosition.dy),
                         end: Offset.zero,
                       ).animate(animation),
                     );
                   }
               ));
*/

// Navigator.push(
//     mainnavigationkey.currentContext!,
//     CupertinoPageRoute(builder: (_) => arfilterscreen()));
// pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
                      }
                    },
                    child:body(),
                  ),

                );

            case HomeDatareceiveError:
              return NestedScrollView(
                  headerSliverBuilder:(context,index){
                    return [SliverAppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.white,
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.white,
                      pinned: true,
                      elevation:index == 0 ?0:2,
                      automaticallyImplyLeading: false,
                      title: const Text("Home",style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),),
                      actions: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
                        }, icon:const Icon(Icons.message, color: Colors.black87,))
                      ],
                    )];
                  } ,
                  body:Center(
                    child: createTextThemeWise("Error Receving Data\n Please check your Internet",style: TextStyle(fontSize: 18,color: Colorcode.backgroundcolor)),
                  ),

                );
              break;
            default:
              return Container();
          }
       },

     ),
   );
  }
  var color = {Colors.amber,Colors.brown,Colors.lime,Colors.lightGreen,Colors.red,Colors.greenAccent,Colors.cyan,Colors.lightBlue};

  Widget body(){
    return /*StreamBuilder<bool>(
      stream: _vmpost.postcontroller.stream,
      initialData:true,
      builder: (context, snapshot) {
        return snapshot.data == false? Container(
          child: ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            itemCount: 10,
            primary: false,
            itemBuilder: (context,index){
              // Datum data1;
              // data1 = postdata1[index];

              return Container(
                constraints: const BoxConstraints(minHeight: 300,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children:  [
                        Container(
                          padding: const  EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          child:  Row(
                            children: [
                              CircleAvatar(
                                radius:16,
                                backgroundColor: Colorcode.backgroundcolor,
                              ),
                              const SizedBox(width: 5,),
                              Container(width: 120,height: 20,color: Colorcode.backgroundcolor,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height:175,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colorcode.backgroundcolor,
                              backgroundBlendMode: BlendMode.color
                          ),
                          //color:Colors.red,

                          // Image.network(data1.image,fit:BoxFit.cover,isAntiAlias:true,scale:1,filterQuality: FilterQuality.high),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
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
                              Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
                              const SizedBox(width: 10,),
                              Flexible(
                                child:Container(width: 120,height: 20,color: Colorcode.backgroundcolor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },),
        ) :*/
        Column(
          children: [
            Container(
              // padding: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              height:60,
              child:  ListView.builder(
                scrollDirection:Axis.horizontal,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                itemCount: postdata1.length,
                itemBuilder:(context,index){
                  Datum data1;
                  data1 = postdata1[index];
                  if (data1.Ads == true) {
                  //   loadAd();
                   return Container();
                  }
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreStories(data1)));
                    },
                    child: Container(
                      // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          shape:BoxShape.circle,
                          border: Border.lerp(Border(), Border(), 2.0)/*Border.all(color: Colors.amber,width: 4,style: BorderStyle.solid)*/,
                          // color:Colors.amber,
                        ),
                        padding: const EdgeInsets.all(2),
                        child:  CircleAvatar(
                            backgroundColor: Colors.orange,
                            radius:30,
                            backgroundImage:const NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") ,
                            foregroundImage:NetworkImage(data1.owner.picture))
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.only(top: 10),
                cacheExtent: 22.0,
                itemCount: postdata1.length,
                primary: true,
                itemBuilder: (context,index){
                  // if(index == 0){
                  //   return Container(
                  //     // padding: const EdgeInsets.only(left: 10),
                  //     width: MediaQuery.of(context).size.width,
                  //     height:60,
                  //     child: StreamBuilder<bool>(
                  //         stream: _vmpost.postcontroller.stream,
                  //         initialData: true,
                  //         builder: (context, snapshot) {
                  //           return snapshot.data == false ? Shimmer.fromColors(
                  //             baseColor: Colors.grey.shade300,
                  //             highlightColor: Colors.grey.shade100,
                  //             enabled: true,
                  //             child: ListView.builder(
                  //               scrollDirection:Axis.horizontal,
                  //               shrinkWrap: true,
                  //               addAutomaticKeepAlives: true,
                  //               itemCount: 10,
                  //               primary: false,
                  //               itemBuilder:(context,index){
                  //                 // Datum data1;
                  //                 // data1 = postdata1[index];
                  //                 return Container(
                  //                   // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(30),
                  //                       //color:color.elementAt(index),
                  //                     ),
                  //                     padding: const EdgeInsets.all(8),
                  //                     child:  CircleAvatar(
                  //                       // backgroundColor: Colors.grey,
                  //                       radius:32,
                  //                       // backgroundImage:NetworkImage(data1.owner.picture)
                  //                     )
                  //                 );
                  //               },
                  //             ),
                  //           )/*Center(child: CircularProgressIndicator(),)*/:
                  //           ListView.builder(
                  //             scrollDirection:Axis.horizontal,
                  //             shrinkWrap: true,
                  //             addAutomaticKeepAlives: true,
                  //             itemCount: postdata1.length,
                  //             itemBuilder:(context,index){
                  //               Datum data1;
                  //               data1 = postdata1[index];
                  //               return InkWell(
                  //                 onTap: (){
                  //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreStories()));
                  //                 },
                  //                 child: Container(
                  //                   // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(30),
                  //                       //color:color.elementAt(index),
                  //                     ),
                  //                     padding: const EdgeInsets.all(6),
                  //                     child:  CircleAvatar(
                  //                         backgroundColor: Colors.orange,
                  //                         radius:28,
                  //                         backgroundImage:NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png") ,
                  //                         foregroundImage:NetworkImage(data1.owner.picture))
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //         }
                  //     ),
                  //   );
                  // }
                  Datum data1;
                  data1 = postdata1[index];
                  if (data1.Ads == true) {
                    //   loadAd();
                    // return adsView();
                    return Container();
                  }
                  // loadAd();
                  // return adsView();
                  return PostContent(data1);
                },),
            ),
          ],
        );
    //   }
    // );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => postdata1 != [] || postdata1.length != 0 ? true : false;

  getcomments(String id, Datum data1) {
    // getcommentslist(id,commentstreams,data1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
          child: createTextThemeWise("Comments",style: const TextStyle(color: Colors.grey)),
        ),

        StreamBuilder<bool>(
            // future: getcommentslist(id),
          stream: commentstreams.stream,
            initialData:data1.commentlist != null ? true : false,
            builder: (context,snapshoot){
              CommentModel data;
              if (snapshoot.data == true) {
                data  =data1.commentlist;
                // data1.commentlist = snapshoot.data as CommentModel?;
              }
              print(data?.data.length);
          return data?.data != null ?Container(
            padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
            child: Column(
              children: List.generate(data.data.length, (index) => Container(
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
          ):const Center(
            child:CircularProgressIndicator(color: Colors.black38,backgroundColor: Colors.white54,)
          );
        }),
      ],
    );
  }

   /*getcommentslist(String id, StreamController<bool> commentstreams, Datum data1) async {
    if (data1.commentlist == null) {
      var data =  await _vmpost.getcommentslist(id);
      data1.commentlist = data ??[];
    }
    commentstreams.add(true);
  }*/

  void getdata()async{
    try {
     var ref = firestore.collection("12345678");
     QuerySnapshot querySnapshot = await ref.get();

     // Get data from docs and convert map to List
     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
     print(ref);
     if (allData != null || allData !=[] ) {
       for(int i = 0;i<allData.length;i++){
        Map data =  allData[i] as Map;
         Datum dtam = Datum(id:data["id"], image: data["image"], likes: data["likes"].toString(), tags: data["tags"], text:data["text"]??"", publishDate: (data["publishDate"] as Timestamp).toDate(), owner: data["owner"], isfirebase:true);
         postdata1.add(dtam);
       }
     }
      // var ref = FirebaseDatabase.instance.reference();
      //  ref.once().then((value){
      //    print("firebasedata: ${value.value}");
      //    data = value.value;
      //  });
      // print(snapshot.value);
     _vmpost.postcontroller.add(true);
    } catch (e) {
      print(e.toString());
      _vmpost.postcontroller.add(true);
    }
  }

  // Widget adsView() {
  //   loadAd();
  // return  Container(
  //           color: Colors.red,
  //           height: 200,
  //           alignment: Alignment.center,
  //           child:  AdWidget(ad: _nativeAd),
  //         );
  // }
}






/*

Scaffold(
appBar: AppBar(
systemOverlayStyle: const SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarBrightness: Brightness.dark,
systemNavigationBarColor: Colors.white,
systemNavigationBarDividerColor: Colors.black45,
systemNavigationBarContrastEnforced: true,
systemNavigationBarIconBrightness: Brightness.light,
statusBarIconBrightness: Brightness.dark
),
backgroundColor: Colors.white38,
elevation:0,
automaticallyImplyLeading: false,
title: const Text("Home",style: TextStyle(
color: Colors.black,
fontSize: 24,
fontWeight: FontWeight.w500,
),),
actions: [
IconButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>messages()));
}, icon:const Icon(Icons.message, color: Colors.black87,))
],
),
body: GestureDetector(
onHorizontalDragStart: (details){
if(details.globalPosition.dx <= 30.5){
*/
/*Navigator.of(mainnavigationkey.currentContext!).push(PageRouteBuilder(
                 opaque: true,
                 transitionDuration: const Duration(milliseconds: 10),
                 pageBuilder: (BuildContext context, _, __) {
                   return new arfilterscreen();
                 },
                 transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                   return SlideTransition(
                     child: child,
                     position:  Tween<Offset>(
                       begin:  Offset(details.globalPosition.dx, details.globalPosition.dy),
                       end: Offset.zero,
                     ).animate(animation),
                   );
                 }
             ));*//*

// Navigator.push(
//     mainnavigationkey.currentContext!,
//     CupertinoPageRoute(builder: (_) => arfilterscreen()));
// pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
}
},
child:body() */
/*Container(color:Colors.white)*//*
),

);*/
