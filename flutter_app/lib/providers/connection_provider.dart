import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  String messageSendRequest;
  bool? successSendRequest;

  String messageDisplayRequests;
  List<dynamic>? listOfRequests;
  bool? successDisplayRequests;
  bool? noRequests;

  ConnectionProvider(
      {this.messageSendRequest = "",
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
      messageSendRequest = response.data["message"];

      // print("From ConnectionProvider response: ${response.data}");
    } on DioException catch (error) {
      if (error.response!.statusCode == 405) {
        successSendRequest = false;
        messageSendRequest = "Request already exists";
      } else if (error.response!.statusCode == 403) {
        successSendRequest = false;
        messageSendRequest = "Email doesn't exist";
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
    // print("in displayIncomingRequests");
    try {
      final response = await dio.get("$baseUrl/display_requests",
          options: Options(headers: {'authorization': 'Bearer $token'}));
      // print("in controller: ${response.data}");
      if (response.data["status"] == "success") {
        successDisplayRequests = true;
        noRequests = false;
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

  /// Accept or Reject request
  ///
  respondToRequest(token, requestID, userResponse) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post("$baseUrl/respond_to_request",
          data: {'request_id': requestID, 'response': userResponse});
      print("from provider: ${response.data}");
      if (response.data["status"] == "success") {
        if (response.data["request"]["status"] == "rejected") {
          listOfRequests?.removeWhere(
              (element) => element['id'] == response.data["request"]["id"]);
          notifyListeners();
        }
      }
    } on DioException catch (error) {
      print(error);
    }
  }
}
