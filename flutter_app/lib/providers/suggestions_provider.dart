import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionsProvider extends ChangeNotifier {
  final _dio = Dio();
  final String _baseUrl = Requests.baseUrl;

  String? status;
  String? failedMessage;

  Future getSuggestions(String type) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.get("$_baseUrl/get_suggestions",
          data: {"place_type": type},
          options: Options(headers: {"authorization": "Bearer $token"}));
      print("In suggestions provider success: ${response.data}");
      if (response.data["status"] == "failed") {
        status = "failed";
        failedMessage = response.data["message"];
      } else if (response.data["status"] == "success") {
        status = "success";
      }
    } catch (error) {
      print("In suggestions provider: $error");
    }
    notifyListeners();
  }
}
