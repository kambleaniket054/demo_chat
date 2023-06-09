import 'package:demo_chat/Model/instaPostmodel.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/serchdetail.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class searchpage extends StatefulWidget{
  createState()=>searchpagestate();
}
class searchpagestate extends State<searchpage> with AutomaticKeepAliveClientMixin<searchpage>{
  GlobalKey key = GlobalKey();
  vm_post  _vmpost = vm_post();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      print(key.currentContext?.size?.width);
    });
    _vmpost.getpost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> serchdetail()));
          },
          child: Container(
            key: key,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200.withOpacity(0.5),
              border: Border.all(color: Colors.black54.withOpacity(0.5)),
            ),
            margin: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
            child:  Row(
              children:  [
                Icon(Icons.search,color: Colors.black45,),
                Container(width: 10/*(key.currentContext?.size?.width)!/2*/,color: Colors.cyan,),
                const Text("Search",style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),),
              ],
            ),
          ),
        ),
      ),
      body:StreamBuilder<bool>(
        stream: _vmpost.postcontroller.stream,
        initialData:  postdata1==null?false:true,
        builder: (context, snapshot) {
          return snapshot.data == false? Center(
            child: CircularProgressIndicator(),
          ):Container(color:Colors.white,
          child: GridView.builder(
              addAutomaticKeepAlives:true,
              addRepaintBoundaries: true,
              cacheExtent: 9999,
              itemCount: postdata1.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing:3,crossAxisSpacing: 3,childAspectRatio: 0.8,) ,
              itemBuilder: (context, index){
              Datum data;
              data = postdata1[index];
              return Container(
                child: CachedNetworkImage(

                  imageUrl: data.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.black38,backgroundColor: Colors.white54,)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
                // Image.network(data.image,fit:BoxFit.cover),
              );
              }
          ),
          );
        }
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}