// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// class PhotoEditingScreen extends StatefulWidget {
//   @override
//   _PhotoEditingScreenState createState() => _PhotoEditingScreenState();
// }
//
// class _PhotoEditingScreenState extends State<PhotoEditingScreen> {
//   FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
//    var editedImageFile = null;
//   late String _pickFile;
//   StreamController<bool> pickedimageConrtoller = StreamController<bool>.broadcast();
//   final _formKey = GlobalKey<FormState>();
//   final _text = TextEditingController();
//   bool loading = true;
//   Future<void> editAndUploadPhoto() async {
//     loading = true;
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       // setState(() {
//       //   _image = File(pickedFile.path);
//       // });
//       _pickFile = pickedFile.toString();
//     }
//     Directory externalStorageDirectory = await getExternalStorageDirectory();
//     String externalStoragePath = externalStorageDirectory.path;
//
//     final String inputImagePath = File(pickedFile.path).path;
//     final String outputImagePath = externalStoragePath.toString();
//
//     final String ffmpegCommand =
//         '-y -i $inputImagePath -vf  colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131 -vframes 1 $outputImagePath/new2.jpg';
//
//     final int rc = await _flutterFFmpeg.execute(ffmpegCommand);
//
//     if (rc == 0) {
//       print('Photo edited successfully');
//
//       // Upload edited photo to Firebase Storage
//       editedImageFile = File("${outputImagePath}/new2.jpg");
//       final String storagePath = 'photos/${DateTime.now().microsecondsSinceEpoch}.jpg';
//       loading = false;
//       pickedimageConrtoller.add(true);
//   try {
//         // final Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);
//         // await storageRef.putFile(editedImageFile);
//         //
//         // final String downloadURL = await storageRef.getDownloadURL();
//         // print('Photo uploaded to Firebase Storage: $downloadURL');
//       } catch (e) {
//         print('Failed to upload photo to Firebase Storage: $e');
//       }
//     } else {
//       print('Failed to edit photo');
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     editAndUploadPhoto();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.close,color:Colors.white60),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: GestureDetector(
//                 onTap:(){},
//                 child:  Text('Share', style: Theme.of(context).primaryTextTheme.bodyText1),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: /*loading
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             CircularProgressIndicator(),
//             SizedBox(height: 12),
//             Text('Uploading...')
//           ],
//         ),
//       )
//           :*/ ListView(
//         children: [
//           SizedBox(
//             height: 400,
//             child: /*(editedImageFile != null)
//                 ?*/Column(
//               children: [
//                 StreamBuilder<bool>(
//                   initialData: false,
//             stream:pickedimageConrtoller.stream,
//                     builder: (context,snapshot){
//                   return snapshot.data == false ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 12),
//                         Text('Uploading...')
//                       ],
//                     ),
//                   ) : FadeInImage(
//                     fit: BoxFit.contain,
//                     placeholder: const AssetImage("assets/topolino.jpg"),
//                     image: Image.file(File(editedImageFile!.path)).image,
//                   );
//                 }),
//                 InkWell(
//                   onTap: (){
//                     editAndUploadPhoto();
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                             Color(0xFFFFB344),
//                             Color(0xFFE60064)
//                           ]),
//                     ),
//                     // height: 300,
//                     child: const Center(
//                       child: Text(
//                         'Tap to select an image',
//                         style: TextStyle(
//                           color: Colors.black /*Color(0xFFFAFAFA)*/,
//                           fontSize: 18,
//                           shadows: <Shadow>[
//                             Shadow(
//                               offset: Offset(2.0, 1.0),
//                               blurRadius: 3.0,
//                               color: Colors.black54,
//                             ),
//                             Shadow(
//                               offset: Offset(1.0, 1.5),
//                               blurRadius: 5.0,
//                               color: Colors.black54,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 22,
//           ),
//           Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 controller: _text,
//                 decoration: const InputDecoration(
//                   hintText: 'Write a caption',
//                   border: InputBorder.none,
//                 ),
//                 validator: (text) {
//                   if (text == null || text.isEmpty) {
//                     return 'Caption is empty';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: StickerGridView(
//               controller: _stickerController,
//               onStickerSelected: (sticker) {
//                 // Handle sticker selection
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// /*Scaffold(
//       appBar: AppBar(
//         title: Text('Photo Editing App'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             if (editedImageFile == null) Container() else Image.file(editedImageFile),
//             RaisedButton(
//               onPressed: () {
//                 editAndUploadPhoto();
//               },
//               child: const Text('Edit and Upload Photo'),
//             ),
//           ],
//         ),
//       ),
//     );*/
//
// }

import 'dart:convert';
import 'dart:io';
import 'package:demo_chat/Homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:demo_chat/Model/userdetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Homescreen.dart';
import 'globalfunction.dart';

class photoeditscreen extends StatelessWidget{
  File file;
  photoeditscreen(this.file);
 TextEditingController _descriptionController = TextEditingController();

 @override
  Widget build(BuildContext context) {

    return  Scaffold(
      extendBody: false,
      appBar: AppBar(
    backgroundColor:Colors.white,
    elevation: 0.0,
    foregroundColor: Colors.black87,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back), onPressed: () {
      Navigator.pop(context);
    },
   // onPressed: clearImage,
   ),
   title: const Text(
   'Post to',
   ),
   centerTitle: false,
        actions: [
          TextButton(onPressed: ()async{
            showDialog(context: context,builder: (context){
              return Center(child: CircularProgressIndicator(),);
            }
            );
            // required this.id,
            // required this.image,
            // required this.likes,
            // required this.tags,
            // required this.text,
            // required this.publishDate,
            // required this.owner,
            // this.commentlist,
            List<int> imageBytes = await file.readAsBytes();
            var img =  base64Encode(imageBytes);
            Map<String, dynamic> submap = {
              "id": usredetails.uid.toString(),
              "publishDate":Timestamp.now(),
              "image":img,
              "likes":'0',
              "tags":[""],
              "text":'new post',
              "owner":usredetails.displayName ?? "USER",
            };

            // Map<String, dynamic> messagedata = {submap};
            // FieldValue.arrayUnion(["greater_virginia"]
            FirebaseFirestore.instance.collection("12345678").doc().set(submap).then((value){
              print("success");
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>homescreen()),(Routes){
                return false;
              });
              // Navigator.pop(context);
              // Navigator.pop(context);

              // Messagecontroller.clear();
            }).onError((error, stackTrace){
              print(error.toString());
              Navigator.pop(context);
            });
          }, child: Text("Submit",style: TextStyle(color: Colors.blue,fontSize: 18),)),
        ],
   ),
      body: Column(
        children: <Widget>[
          // const Padding(padding: EdgeInsets.only(top: 10.0)),
          const Divider(),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage("",
                    // userdetail.profileimage,
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
                            image: MemoryImage(file.readAsBytesSync()),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}