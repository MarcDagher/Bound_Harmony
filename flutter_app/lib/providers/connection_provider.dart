import 'dart:async';

import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionProvider extends ChangeNotifier {
  SharedPreferences? preferences;

  // sendRequst method
  String messageSendRequest = "";
  bool? successSendRequest;

  // displayIncomingRequests method
  String messageDisplayRequests = "";
  List<dynamic>? listOfRequests;
  bool? successDisplayRequests;
  bool? noRequests;

  // respondToRequest method
  bool sendResponseFail = false;
  String failedResponseMessage = "";

  // getPartners method
  List listOfPartners = [];
  bool currentPartner = false;

  // disconnect method
  String disconnectMessage = "";

  /// Send a request to connect with partner
  Future sendRequest(String email, token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post("$baseUrl/send_request",
          data: {'email': email},
          options: Options(headers: {'authorization': 'Bearer $token'}));

      successSendRequest = true;
      messageSendRequest = response.data["message"];
    } on DioException catch (error) {
      if (error.response?.statusCode == 405) {
        successSendRequest = false;
        messageSendRequest = "Request already exists";
      } else if (error.response!.statusCode == 403) {
        successSendRequest = false;
        messageSendRequest = "Email doesn't exist";
      }
    }
    notifyListeners();
  }

  /// Display user's pending incoming requests
  displayIncomingRequests(token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();
    try {
      final response = await dio.get("$baseUrl/display_requests",
          options: Options(headers: {'authorization': 'Bearer $token'}));
      // success
      if (response.data["status"] == "success") {
        successDisplayRequests = true;
        noRequests = false;
        listOfRequests = response.data["requests"];
      }
      // user doeasn't have incoming requests
      else if (response.data["status"] == "No requests") {
        noRequests = true;
        messageDisplayRequests = response.data["message"];
      }
      // user is already connected
      else if (response.data["status"] == "rejected") {
        noRequests = false;
        currentPartner = true;
      }
    } on DioException catch (error) {
      print(
          "in provider displayIncomingRequests: ${error.response!.statusCode}");
    }

    notifyListeners();
  }

  /// Accept or Reject request
  respondToRequest(token, requestID, userResponse) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post("$baseUrl/respond_to_request",
          data: {'request_id': requestID, 'response': userResponse});

      sendResponseFail = false;

      /// rejecting a request
      if (response.data["request"]["status"] == "rejected") {
        listOfRequests?.removeWhere(
            (element) => element['id'] == response.data["request"]["id"]);
        if (listOfRequests!.isEmpty) {
          noRequests = true;
        } else {
          noRequests = false;
        }
        notifyListeners();
      } else if (response.data["request"]["status"] == "accepted") {
        currentPartner = true;

        notifyListeners();
      }
    } on DioException catch (error) {
      /// When i got error status 302,i'm not sure what the error is. I refresh cntrl + s in connection provider and it works
      print("In respondToRequest: $error");
      if (error.response?.statusCode == 302) {
        sendResponseFail = true;
        failedResponseMessage =
            "Connection error occured, please try again later";
      }
    }
  }

  /// Display user's partners
  getPartners(token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.get("$baseUrl/display_history",
          options: Options(headers: {"authorization": "Bearer $token"}));

      listOfPartners = response.data["connections"];
      int count = 0;
      // searching for a connection with current partner (status == "accepted")
      for (int i = 0; i < response.data["connections"].length; i++) {
        if (response.data["connections"][i]['status'] == 'accepted') {
          count++;
        }
      }
      if (count > 0) {
        currentPartner = true;
      } else {
        currentPartner = false;
      }
      // print(response.data["connections"][0]["status"]);
    } on DioException catch (error) {
      print("In getPartners provider: $error");
    }

    notifyListeners();
  }

  /// Disconnect from current partner
  disconnect(token, int connectionId) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.post("$baseUrl/disconnect",
          data: {"connection_id": connectionId},
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.data["connection"]["status"] == "disconnected") {
        listOfRequests?.removeWhere(
            (element) => element['id'] == response.data["connection"]["id"]);
        currentPartner = false;
        disconnectMessage = "Disconnected successfuly";
        notifyListeners();
      } else {
        disconnectMessage = "Something went wrong";
        notifyListeners();
      }
    } on DioException catch (error) {
      print("Error: $error");
    }
  }
}
