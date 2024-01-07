import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  String message;
  bool? successSendRequest;

  String messageDisplayRequests;
  List<dynamic>? listOfRequests;
  bool? successDisplayRequests;
  bool? noRequests;

  ConnectionProvider(
      {this.message = "",
      this.successSendRequest,
      this.successDisplayRequests,
      this.messageDisplayRequests = "",
      this.listOfRequests,
      this.noRequests});

  /// Send a request
  ///
  Future sendRequest(String email, token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      // print("From ConnectionProvider: $token");
      final response = await dio.post("$baseUrl/send_request",
          data: {'email': email},
          options: Options(headers: {'authorization': 'Bearer $token'}));

      successSendRequest = true;
      message = response.data["message"];

      // print("From ConnectionProvider response: ${response.data}");
    } on DioException catch (error) {
      if (error.response!.statusCode == 405) {
        successSendRequest = false;
        message = "Request already exists";
      } else if (error.response!.statusCode == 403) {
        successSendRequest = false;
        message = "Email doesn't exist";
      }
      // print("From ConnectionProvider error: $error");
    }
    notifyListeners();
  }

  /// Display incoming requests
  ///
  displayIncomingRequests(token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    print("in displayIncomingRequests");
    try {
      final response = await dio.get("$baseUrl/display_requests",
          options: Options(headers: {'authorization': 'Bearer $token'}));
      print("in controller: ${response.data}");
      if (response.data["status"] == "success") {
        successDisplayRequests = true;
        listOfRequests = response.data["requests"];
      } else if (response.data["status"] == "No requests") {
        noRequests = true;
        messageDisplayRequests = response.data["message"];
      }
    } on DioException catch (error) {
      print("in controller: ${error.response!.statusCode}");
    }

    notifyListeners();
  }
}
