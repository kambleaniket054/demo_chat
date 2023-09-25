import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:demo_chat/Colorcode.dart';
import 'package:demo_chat/photoeditscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../globalfunction.dart';
import 'edit_photo_page.dart';

class fetchimageview extends StatefulWidget {
  const fetchimageview({Key? key}) : super(key: key);

  @override
  fetchimageviewState createState() => fetchimageviewState();
}

class fetchimageviewState extends State<fetchimageview> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  late  List<AssetEntity> recentAssets = [];
  var selectedimage;
  List<AssetEntity> videolist = [];
  List<AssetEntity> imagelist = [];
StreamController filtercontroller = StreamController<String>();
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickimages();
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickimages();
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  // void postImage(String uid, String username, String profImage) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // start the loading
  //   try {
  //     // upload to storage and db
  //     String res = await FireStoreMethods().uploadPost(
  //       _descriptionController.text,
  //       _file!,
  //       uid,
  //       username,
  //       profImage,
  //     );
  //     if (res == "success") {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       if (context.mounted) {
  //         showSnackBar(
  //           context,
  //           'Posted!',
  //         );
  //       }
  //       clearImage();
  //     } else {
  //       if (context.mounted) {
  //         showSnackBar(context, res);
  //       }
  //     }
  //   } catch (err) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showSnackBar(
  //       context,
  //       err.toString(),
  //     );
  //   }
  // }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  void  initState() {
    // TODO: implement initState
    super.initState();
    fetchinmages();
  }

  List<DropdownMenuItem<String>> droplist = [DropdownMenuItem(child: Center(child: Text("Images",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),value: "Images",),DropdownMenuItem(child: Center(child: Text("videos")),value: "videos",)];

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colorcode.backgroundcolor,
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: true,
        /*leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black87,),
          onPressed: clearImage,
        ),*/
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: ()async{
              var imagedata = await selectedimage.file;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>photoeditscreen(imagedata!)));
    },/* postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ),*/
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Expanded(child:selectedimage != null ? AssetEntityImage(
            selectedimage,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            isOriginal: true, // Defaults to `true`.
            thumbnailSize: const ThumbnailSize.square(200), // Preferred value.
            thumbnailFormat: ThumbnailFormat.jpeg,
            // loadingBuilder: (context,w,a){
            //   return Shimmer.fromColors(child:Spacer(),  baseColor: Colors.grey.shade300,
            //     highlightColor: Colors.grey.shade100,
            //     enabled: true,);
            // },// Defaults to `jpeg`.
          ) : Center(child:Text("Select image",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black38),)),),
          SizedBox(height: 15,),
          recentAssets == [] ? const Center(
            child: CircularProgressIndicator(),
          ):Expanded(
    child:StreamBuilder(
      initialData: 'Images',
      stream: filtercontroller.stream,
      builder: (context, snapshot) {
        if (snapshot.data == 'videos') {
          recentAssets = videolist;
        }
        else{
          recentAssets = imagelist;
        }
        return Container(
          decoration: BoxDecoration(
            color: Colorcode.foreground,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(12) ),
          ),
          padding: EdgeInsets.only(top: 10,right: 8,left: 8),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 100,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colorcode.backgroundcolor,
                ),
                child: DropdownButton(
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  value: snapshot.data,
                  underline: Container(),
                  hint: Center(child: droplist.first),
                  items:droplist, onChanged: (value) {
                  filtercontroller.add(value);
                },
                ),
              ),
              SizedBox(height: 10,),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: true,
                    // controller: widget.scrollCtr,
                    itemCount: recentAssets.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 1.5,mainAxisSpacing:1.5),
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder<File?>(
                          future: recentAssets[index].file,
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Container(color: Colors.grey[100],);
                            }
                            if(snapshot.data == null){
                              recentAssets.removeAt(index);

                            }
                            return InkWell(
                                onTap: (){
                                  selectedimage = recentAssets[index];
                                  setState(() {

                                  });
                                },
                                child: AssetEntityImage(
                                  recentAssets[index],
                                  fit: BoxFit.cover,
                                  isOriginal: false, // Defaults to `true`.
                                  thumbnailSize: const ThumbnailSize.square(200), // Preferred value.
                                  thumbnailFormat: ThumbnailFormat.jpeg,
                                  // loadingBuilder: (context,w,a){
                                  //   return Shimmer.fromColors(child:Spacer(),  baseColor: Colors.grey.shade300,
                                  //     highlightColor: Colors.grey.shade100,
                                  //     enabled: true,);
                                  // },// Defaults to `jpeg`.
                                ),/*Image.file(snapshot.data!)*/);
                          });
                    }),
              ),
            ],
          ),
        );
      }
    ),/*ListView.builder(
        itemCount:recentAssets.length,
        itemBuilder: (context,index){
      return FutureBuilder<File?>(
          future: recentAssets[index].file,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: const CircularProgressIndicator());
            }
        return Image.file(snapshot.data!);
      });
    })*/
    ),
          /*isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "",
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(_file!),
                        )),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),*/
        ],
      ),
    );
  }
   pickimages()async {

    pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    return pickedFile.readAsBytes();

    // Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPhotoPage()));
  }

  void fetchinmages()async {
    try {
      // final PermissionState ps = await PhotoManager.requestPermissionExtend();
      // if (ps.isAuth) {
        final albums = await PhotoManager.getAssetPathList(hasAll: true);
        final recentAlbum = albums.first;

        // Now that we got the album, fetch all the assets it contains
        List<AssetEntity> albumres = await recentAlbum.getAssetListRange(
          start: 0, // start at index 0
          end: 1000000, // end at a very big index (to get all the assets)
        );

        albumres.forEach((element) {
          if( element.type == AssetType.video){
            videolist.add(element);
          }
          else{
            imagelist.add(element);
          }
         });
        // Update the state and notify UI
        setState(() {});
      // } else {
        // Limited(iOS) or Rejected, use `==` for more precise judgements.
        // You can call `PhotoManager.openSetting()` to open settings for further steps.
      // }

    } catch (e) {
     print("photomanager error"+e.toString());
    }

  }
}






// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../globalfunction.dart';
// import 'edit_photo_page.dart';
//
// class fetchimageview extends StatefulWidget{
//   createState()=> fetchimageviewstate();
// }
//
// class fetchimageviewstate extends State<fetchimageview>{
//  // late final PickedFile pickedFile;
// @override
//   void initState() {
//     // TODO: implement initState
//   super.initState();
//     pickimages();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    return Container();
//   }
//
//   void pickimages()async {
//
//     pickedFile = await ImagePicker().getImage(
//         source: ImageSource.gallery,
//         );
//
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPhotoPage()));
//   }
//
// }

