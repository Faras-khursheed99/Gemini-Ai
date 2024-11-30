import 'dart:convert';
import 'package:api/gemini/gemini_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeminiProvider extends ChangeNotifier {
  List<String> message = [];
  geminiapi geminiModel = geminiapi();
  bool isLoading = false;

  Future<void> geminiresponse(String search) async {
    message.add(search);
    isLoading = true;
    notifyListeners();

    print('Waiting for Gemini response...');
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAHpxotFqUxzVLkLiRGVkDK0_SbJu5Kn2Y";

    dynamic headers = {"Content-Type": "application/json"};

    dynamic body = {
      "contents": [
        {
          "parts": [
            {"text": search}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        dynamic maxdata = jsonDecode(response.body);
        geminiModel = geminiapi.fromJson(maxdata);

        String aiResponse =
            geminiModel.candidates?[0].content?.parts?[0].text ??
                "No response available";

        message.add(aiResponse);
        print('Gemini response:Rsponse Fetched');
      } else {
        message.add("Error: Unable to fetch response. Try again.");
        print('Error response: fetched');
      }
    } catch (e) {
      message.add("Error: An unexpected error occurred.");
      print('Exception: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
