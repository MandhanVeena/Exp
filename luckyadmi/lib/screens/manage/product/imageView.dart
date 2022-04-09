// import 'dart:io';

// import 'package:flutter/material.dart';

// class ImageView extends StatefulWidget {
//   final File image;

//   const ImageView({Key key, this.image}) : super(key: key);

//   @override
//   State<ImageView> createState() => _ImageViewState();
// }

// class _ImageViewState extends State<ImageView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.close),
//             color: Colors.black,
//           ),
//           actions: [
//             IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: () {})],
//         ),
//         backgroundColor: Colors.black,
//         body: Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Container(

//             child: Image.file(widget.image,
//             fit: BoxFit.cover,
//             ),
//           ),
//         ));
//   }
// }
