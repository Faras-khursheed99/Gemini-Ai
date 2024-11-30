import 'package:api/API/Get_Albam_API/album_screen.dart';
import 'package:api/API/Get_Photo_Api/photo_screen.dart';
import 'package:api/API/Get_comment_Api/Get_screen.dart';
import 'package:api/API/Get_post_Api/post_Screen.dart';
import 'package:api/gemini/gemini_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GeminiScreen(),
      //PhotoScreenApi(),
      //AlbumScreen(),
      // Get_Comment()
      // Api_PostScreen()
    );
  }
}
