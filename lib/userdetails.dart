import 'package:demo_chat/profileBloc/porfilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Model/instaPostmodel.dart';
import 'globalfunction.dart';
import 'profileBloc/profileEvent.dart';
import 'profileBloc/profileState.dart';

class userdetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return userdetailstate();
  }
}

class userdetailstate  extends State<userdetails>{

 bool data = true;
 profilecontroller profilec = profilecontroller();
 @override
  void initState() 
 {
   profilec.add(fecthprofiledetails(uid:usredetails.uid));
    // TODO: implement initState
    super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: data == true ?AppBar(
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black,
         systemNavigationBarIconBrightness: Brightness.light,
       ),
       backgroundColor: Colors.white,
       elevation: 0.5,
       automaticallyImplyLeading: false,
       title: Text("Details",style: TextStyle(
         color: Colors.black,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
       actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline)),
         IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
       ],
     )  : AppBar(
       systemOverlayStyle:const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black,
         systemNavigationBarIconBrightness: Brightness.light,
       ),
       backgroundColor: Colors.white,
       elevation: 0.5,
       automaticallyImplyLeading: false,
       title: Text("Details",style: TextStyle(
         color: Colors.black,
         fontSize: 24,
         fontWeight: FontWeight.w500,
       ),),
       actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline)),
         IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
       ],
     ),
     body: Column(
       children: [
         Container(
           padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
           child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                   margin: const EdgeInsets.only(left:0,right: 10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30),
                     //color:color.elementAt(index),
                   ),
                   padding: const EdgeInsets.all(12),
                   child:  CircleAvatar(
                       backgroundColor: Colors.orange,
                       radius:48,
                       foregroundImage: AssetImage("assets/ArcticFox.gif"))
               ),
               // CircleAvatar(
               //   child: Image.network("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHwAAAB8CAMAAACcwCSMAAAAMFBMVEXk5ueutLersbTP09Xn6eqxt7rh4+S2u77Y29zV2Nq8wcTJzc/d4OG5vsHCx8nFysx2ylK/AAACtklEQVRoge2aSZLDIAxFGQTY4OH+t208tJPOAJIjuatS/E1S3jwLhIAvK9XU1NTU1NTU1NTU9L0C+Pt7JdnbOY4hhHFK3aUvACoFY4zelP9FexUehniA9fECSV2ABzU9oVe8tuJ06Nwr9IqP0mz7Dr3Q3SDKTgX2ok5u6GGusLURo1fjXuhCIw99na21k4ErBDqHPkkMPERM4Jne89Ohw7FlBj4g2dok7tBx2baH7rnhI5qtDXeVR8/4osALx9SXO/FWGnAUNnPKDRS21iMrnJDra+iccOKU824v2NJ6wDtOOLq87XDOlU5LduZ0BxqbGU6bcm3mr4mcmnCscMKetsI5TzMw/ec6L11UXsEZ2Xk7J7G1493QaYHzHp8hkuA9J5u6p/KylSdUd/ZLS/2CeifOhbaKcJDiPUQtwtcZkVsyli1xTUVXOX60wh7kuNf4IcRyYz1G/FE9402Us6P8P7Jz7G/9x5Ut4sfc5Mf3dGNF0Wq5OenXeOME7ceD7p8d783zvkQwPLjexrhL7PYdr2x0ZpcOc3dtoyXT/NBba/vBXxf0Rl5wftftyQVc39kpjsGtrZ089y6EOKXey3a5MrhL21w/J3t+Ns69EB9gSOML7MMrOIHky2T3prg8voDm5YPqI478yw/W8+Dzmg5Eb2CptYkDD7a4kRXC/7joFXp4dfxnntSyh5xFr/hwfqM7O+L3ms/CiXbEm+CHE8GD/zzsDU/3Z/DNpDqdak1RTZgynXauZGUT6ZQ+Fjedcb4POnrea/eSU3RszhONVqRQlgHJfSEI1ekjmo1oYaad6m4TVO/vcq+ym+rrjdpTINFrbLnAEaGTDF6yymwvGHit18e8oTypaNnQbHW6yl9TENuWVBUbP4PsqJcnXXKhrfCCPwnJCKtkxXdWWqWEu/wD2qampqYv1Q/CWR25WJskOAAAAABJRU5ErkJggg=="),
               // ),
               Column(
                 children: [
                   Text("Posts",style: TextStyle(
                     color: Colors.black,
                     fontSize: 18,
                     fontWeight: FontWeight.w500,
                   ),),
                   Text("104"),
                 ],
               ),
               Column(
                 children: [
                   Text("Followers",style: TextStyle(
                     color: Colors.black,
                     fontSize: 18,
                     fontWeight: FontWeight.w500,
                   ),),
                   Text("14,003"),
                 ],
               ),
               Column(
                 children: [
                   Text("Following",style: TextStyle(
                     color: Colors.black,
                     fontSize: 18,
                     fontWeight: FontWeight.w500,
                   ),),
                   Text("14,003"),
                 ],
               ),
             ],
           ),
         ),
         Expanded(
           child: DefaultTabController(
             initialIndex: 0,
             length: 3,
             child: Container(
               // height: MediaQuery.of(context).size.height/2*7,
               child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                   const TabBar(tabs: [
                     Tab(icon: Icon(Icons.photo_rounded,color: Colors.black38,),iconMargin: EdgeInsets.only(bottom: 0),),
                     Tab(icon: Icon(Icons.video_camera_back_rounded,color: Colors.black38,),iconMargin: EdgeInsets.only(bottom: 0),),
                     Tab(icon: Icon(Icons.tag,color: Colors.black38,),iconMargin: EdgeInsets.only(bottom: 0),),
                   ],
                   indicatorColor:Colors.black38,
                     indicatorPadding: EdgeInsets.only(top:2,bottom: 5),
                     unselectedLabelColor: Colors.black38,
                   ),
                   Flexible(
                     child: TabBarView(children: [
                       Container(color:Colors.white,
                         child: GridView.builder(
                             addAutomaticKeepAlives:true,
                             addRepaintBoundaries: true,
                             cacheExtent: 9999,
                             itemCount: postdata1.length,
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing:3,crossAxisSpacing: 3,childAspectRatio: 0.8,) ,
                             itemBuilder: (context, index){
                               Datum data;
                               data = postdata1[index];
                               return Container(
                                   child: CachedNetworkImage(
                                     imageUrl: data.image,
                                     progressIndicatorBuilder: (context, url, downloadProgress) =>
                                         Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.black38,backgroundColor: Colors.white54,)),
                                     errorWidget: (context, url, error) => const Icon(Icons.error),
                                   )
                                 // Image.network(data.image,fit:BoxFit.cover),
                               );
                             }
                         ),
                       ),
                       Container(),
                       Container(),
                     ]),
                   ),
                 ] ,
               ),
             ),
           ),
         ),
       ],
     ),
   );
  }

}