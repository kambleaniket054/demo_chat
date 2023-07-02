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