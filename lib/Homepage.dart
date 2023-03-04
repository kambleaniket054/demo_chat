import 'package:demo_chat/Model/commentModel.dart';
import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/arfilterscreen.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_database/firebase_database.dart';

class homepage extends StatefulWidget{
  createState() => homepagestate();  
}
class homepagestate extends State<homepage> with AutomaticKeepAliveClientMixin<homepage>{
vm_post _vmpost = vm_post();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (postdata1 == null) {
      _vmpost.getpost();
    getdata();
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black,
         systemNavigationBarIconBrightness: Brightness.light,
       ),
       backgroundColor: Colors.white38,
       elevation:0,
       automaticallyImplyLeading: false,
       title: const Text("Home",style: TextStyle(
         color: Colors.black,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
     ),
     body: GestureDetector(
         onHorizontalDragStart: (details){
           if(details.globalPosition.dx <= 30.5){
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
             ));*/
             Navigator.push(
                 mainnavigationkey.currentContext!,
                 CupertinoPageRoute(builder: (_) => arfilterscreen()));
             // pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
           }
         },
         child:body() /*Container(color:Colors.white)*/),

   );
  }
  var color = {Colors.amber,Colors.brown,Colors.lime,Colors.lightGreen,Colors.red,Colors.greenAccent,Colors.cyan,Colors.lightBlue};
  
  Widget body(){
    return ListView(
      addAutomaticKeepAlives: true,
      cacheExtent: 120,
      primary: true,
      physics: const PageScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width,
          height:68,
          child: StreamBuilder<Object>(
    stream: _vmpost.postcontroller.stream,
    initialData: postdata1==null?false:true,
            builder: (context, snapshot) {
              return snapshot.data == false ?const Center(child: CircularProgressIndicator(),):ListView.builder(
                scrollDirection:Axis.horizontal,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                itemCount: postdata1.length ?? 0,
                itemBuilder:(context,index){
                  Datum data1;
                  data1 = postdata1[index];
                      return Container(
                       // margin: const EdgeInsets.only(left:0,right: 10,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          //color:color.elementAt(index),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:  CircleAvatar(
                          backgroundColor: Colors.orange,
                  radius:28,
                  backgroundImage:NetworkImage(data1.owner.picture))
                      );
                },
              );
            }
          ),
        ),
        Divider(
          height: 10,
          thickness: 1,
          endIndent: 10,
          indent: 10,
          color: Colors.black.withOpacity(0.1),
        ),
        StreamBuilder<bool>(
          stream: _vmpost.postcontroller.stream,
          initialData: postdata1==null?false:true,
          builder: (context, snapshot) {
            return snapshot.data == false? const Center(child: CircularProgressIndicator()) :
            ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                itemCount: postdata1.length ?? 5,
              primary: false,
                itemBuilder: (context,index){
                  Datum data1;
                  data1 = postdata1[index];
              return Container(
                constraints: const BoxConstraints(minHeight: 390,
                ),
               // color: Colors.yellow,
                //width: MediaQuery.of(context).size.width,height: 450,
               padding: const EdgeInsets.only(bottom: 10),
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
                           CircleAvatar(
                             radius:16,
                             backgroundImage:NetworkImage(data1.owner.picture) ,
                           ),
                           const SizedBox(width: 5,),
                           Text(data1.owner.firstName +" "+ data1.owner.lastName,style: const TextStyle(
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
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        //color:Colors.red,
                        child: Image.network(data1.image,fit:BoxFit.cover,isAntiAlias:true,scale:1,filterQuality: FilterQuality.high),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.heart),iconSize: 18,),
                      IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.share),iconSize: 18,),
                      IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.bubble_middle_bottom),iconSize: 18,),
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
                              fontSize: 12,
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
                              fontSize: 12,
                            ),),
                            const SizedBox(width: 10,),
                            Flexible(
                              child: Text(data1.text,style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
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
                  getcomments(data1.id),
                ],
              ),
              );
            },);
          }
        ),
       /* Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10),
            
            ),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),
            Container(width: MediaQuery.of(context).size.width,height: 120,color: Colors.red,margin: EdgeInsets.all(10)),


          ],
        ),*/
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  getcomments(String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
          child: createTextThemeWise("Comments", TextStyle(color: Colors.grey)),
        ),

        FutureBuilder<CommentModel>(
            future: getcommentslist(id),
            initialData: null,
            builder: (context,snapshoot){
              CommentModel? data;
              if (snapshoot.data !=null) {
                data  = snapshoot.data as CommentModel?;
              }
              print(data?.data.length);
          return data?.data != null && data?.data.length != 0 ?Container(
            padding: const EdgeInsets.only(left: 16,top: 5,right: 16),
            child: Column(
              children: List.generate(data!.data.length, (index) => Container(
                child: Row(
                  children: [
                    Text(data!.data[index].owner.firstName +" "+ data!.data[index].owner.lastName,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),),
                    const SizedBox(width: 10,),
                    Flexible(
                      child: Text(data!.data[index].message,style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 11,
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
          ):Container();
        }),
      ],
    );
  }

  Future<CommentModel> getcommentslist(String id) async {
    return await _vmpost.getcommentslist(id);
  }

  void getdata()async{
    try {
      var ref = FirebaseDatabase.instance.ref();
       ref.once().then((value){
         print("firebasedata: ${value.snapshot.value}");
         data = value.snapshot.value;
       });
      // print(snapshot.value);
    } catch (e) {
      print(e.toString());
    }
  }
}