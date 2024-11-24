import 'dart:convert';
import 'package:api/API/Get_comment_Api/get_comment_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetProvider extends ChangeNotifier {
  List<getcomment> getlist = [];
  get_comment_api() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var maxdata = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var data in maxdata) {
        getlist.add(getcomment.fromJson(data));
      }
      notifyListeners();
      return getlist;
    } else {
      return getlist;
    }
  }
}
