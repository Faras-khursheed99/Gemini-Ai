import 'dart:convert';

import 'package:api/API/Get_Albam_API/get_album_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumProvider extends ChangeNotifier {
  List<getalbum> albumlist = [];
  getAlbumapi() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var maxdata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var data in maxdata) {
        albumlist.add(getalbum.fromJson(data));
      }
      notifyListeners();
      return albumlist;
    } else {
      return albumlist;
    }
  }
}
