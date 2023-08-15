import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

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
  void  State() {
    // TODO: implement initState
    super.initState();
    fetchinmages();
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () => _selectImage(context),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        // backgroundColor: ,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: (){

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
          isLoading
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
          const Divider(),
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
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );

    // Update the state and notify UI
    setState(() {});

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

