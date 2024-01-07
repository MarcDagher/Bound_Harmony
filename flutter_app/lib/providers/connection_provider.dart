import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  Future sendRequest(String email) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response =
          await dio.post("$baseUrl/send_request", data: {'email': email});
      print("From ConnectionProvider: $response");
    } on DioException catch (error) {
      print("From ConnectionProvider: $error");
    }
    notifyListeners();
  }
}
