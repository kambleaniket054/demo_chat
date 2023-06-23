import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PhotoEditingScreen extends StatefulWidget {
  @override
  _PhotoEditingScreenState createState() => _PhotoEditingScreenState();
}

class _PhotoEditingScreenState extends State<PhotoEditingScreen> {
  FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
   var editedImageFile = null;
  Future<void> editAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() {
      //   _image = File(pickedFile.path);
      // });
    }
    final String inputImagePath = File(pickedFile.path).path;
    final String outputImagePath = File('/path/to/output/edited_image.jpg').path;

    final String ffmpegCommand =
        '-i $inputImagePath -vf "colorchannelmixer=0.5:0:0:0:0.5:0:0:0:0.5:0" $outputImagePath';

    final int rc = await _flutterFFmpeg.execute(ffmpegCommand);

    if (rc == 0) {
      print('Photo edited successfully');

      // Upload edited photo to Firebase Storage
      editedImageFile = File(outputImagePath);
      final String storagePath = 'photos/${DateTime.now().microsecondsSinceEpoch}.jpg';

      try {
        // final Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);
        // await storageRef.putFile(editedImageFile);
        //
        // final String downloadURL = await storageRef.getDownloadURL();
        // print('Photo uploaded to Firebase Storage: $downloadURL');
      } catch (e) {
        print('Failed to upload photo to Firebase Storage: $e');
      }
    } else {
      print('Failed to edit photo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Editing App'),
      ),
      body: Center(
        child: Column(
          children: [
            if (editedImageFile == null) Container() else Image.file(editedImageFile),
            RaisedButton(
              onPressed: () {
                editAndUploadPhoto();
              },
              child: const Text('Edit and Upload Photo'),
            ),
          ],
        ),
      ),
    );
  }
}