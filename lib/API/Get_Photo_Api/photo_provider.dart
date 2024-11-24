import 'dart:convert';

import 'package:api/API/Get_Photo_Api/get_photo_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoProvider extends ChangeNotifier {
  List<getphotoapi> photolist = [];
  getalbumapi() async {
    var respone = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var maxdata = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      for (var data in maxdata) {
        photolist.add(getphotoapi.fromJson(data));
      }
      notifyListeners();
      return photolist;
    } else {
      return photolist;
    }
  }
}
