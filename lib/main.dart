import 'package:api/API/Get_Albam_API/album_screen.dart';
import 'package:api/API/Get_Photo_Api/photo_screen.dart';
import 'package:api/API/Get_comment_Api/Get_screen.dart';
import 'package:api/API/Get_post_Api/post_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoScreenApi(),
      //AlbumScreen(),
      // Get_Comment()
      // Api_PostScreen()
    );
  }
}
