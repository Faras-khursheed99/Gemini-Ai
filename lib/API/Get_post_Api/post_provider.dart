import 'dart:convert';

import 'package:api/API/Get_post_Api/get_post_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {
  List<postmodel> postlist = [];

  Get_post_api() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var maxdata = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var data in maxdata) {
        postlist.add(postmodel.fromJson(data));
      }
      notifyListeners();
      return postlist;
    } else {
      return postlist;
    }
  }
}
