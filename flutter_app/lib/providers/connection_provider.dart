import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  String? message;
  bool? success;

  Future sendRequest(String email, token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      // print("From ConnectionProvider: $token");
      final response = await dio.post("$baseUrl/send_request",
          data: {'email': email},
          options: Options(headers: {'authorization': 'Bearer $token'}));
      if (response.data["status"] == 'success') {
        success = true;
        message = response.data["message"];
        print(message);
      }
      // print("From ConnectionProvider response: ${response.data}");
    } on DioException catch (error) {
      if (error.response!.statusCode == 405) {
        success = false;
        message = "Request already exists";
        print(message);
      } else if (error.response!.statusCode == 403) {
        success = false;
        message = "Email doesn't exist";
        print(message);
      }
      // print("From ConnectionProvider error: $error");
    }
    notifyListeners();
  }
}
