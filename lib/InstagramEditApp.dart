// import 'package:flutter/material.dart';
// // import 'package:flutter_sticker/flutter_sticker.dart';
// import 'package:sticker_view/stickerview.dart';
//
// class InstagramEditApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Instagram Edit',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: InstagramEditScreen(),
//     );
//   }
// }
//
// class InstagramEditScreen extends StatefulWidget {
//   @override
//   _InstagramEditScreenState createState() => _InstagramEditScreenState();
// }
//
// class _InstagramEditScreenState extends State<InstagramEditScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Instagram Edit'),
//       ),
//       body: Center(
//         child: Image.asset('assets/image.jpg'), // Replace with your image or video widget
//       ),
//     );
//   }
// }
//
//
//
// class _InstagramEditScreenState extends State<InstagramEditScreen> {
//   List stickers = []; // List to store sticker items
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Instagram Edit'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: Image.asset('assets/image.jpg'), // Replace with your image or video widget
//           ),
//           StickerView(
//             stickerList:stickers ,
//             // stickers: stickers,
//             onDelete: (deletedSticker) {
//               setState(() {
//                 stickers.remove(deletedSticker);
//               });
//             },
//             onAdd: (newSticker) {
//               setState(() {
//                 stickers.add(newSticker);
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
// class _InstagramEditScreenState extends State<InstagramEditScreen> {
//   // ...
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ...
//       body: Stack(
//         children: [
//           // ...
//           StickerView(
//             // ...
//             stickerConfig: StickerConfig(
//               minScale: 0.5, // Minimum scale for resizing the sticker
//               maxScale: 2.0, // Maximum scale for resizing the sticker
//               stickerBorderStyle: BorderStyle.dashed, // Border style for stickers
//               stickerBorderWidth: 2.0, // Border width for stickers
//               stickerBorderColor: Colors.white, // Border color for stickers
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class _InstagramEditScreenState extends State<InstagramEditScreen> {
//   // ...
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ...
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) => AddStickerDialog(
//                   onStickerSelected: (newSticker) {
//                     setState(() {
//                       stickers.add(newSticker);
//                     });
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               );
//             },
//             child: Icon(Icons.add),
//           ),
//           SizedBox(height: 16.0),
//           FloatingActionButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) => DeleteStickerDialog(
//                   stickers: stickers,
//                   onDelete: (deletedSticker) {
//                     setState(() {
//                       stickers.remove(deletedSticker);
//                     });
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               );
//             },
//             child: Icon(Icons.delete),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class AddStickerDialog extends StatelessWidget {
//   final Function(StickerItem) onStickerSelected;
//
//   AddStickerDialog({required this.onStickerSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Sticker'),
//       content: Text('Select a sticker to add.'),
//       actions: [
//         FlatButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         FlatButton(
//           child: Text('Add'),
//           onPressed: () {
//             // Add your logic to select a sticker from the available options
//             // and pass it to the onStickerSelected callback
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class DeleteStickerDialog extends StatelessWidget {
//   final List<StickerItem> stickers;
//   final Function(StickerItem) onDelete;
//
//   DeleteStickerDialog({required this.stickers, required this.onDelete});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Delete Sticker'),
//       content: Text('Select a sticker to delete.'),
//       actions: [
//         FlatButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         FlatButton(
//           child: Text('Delete'),
//           onPressed: () {
//             // Add your logic to select a sticker from the available options
//             // and pass it to the onDelete callback
//           },
//         ),
//       ],
//     );
//   }
// }
