import 'dart:async';

import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/providers/auth_provider.dart';
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

  // ConnectionProvider(
  //     {this.preferences,
  //     this.messageSendRequest = "",
  //     this.successSendRequest,
  //     this.successDisplayRequests,
  //     this.messageDisplayRequests = "",
  //     this.listOfRequests,
  //     this.noRequests,
  //     this.sendResponseFail = false,
  //     this.failedResponseMessage = ""});

  /// Send a request
  ///
  Future sendRequest(String email, token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      print("From ConnectionProvider: $token");
      final response = await dio.post("$baseUrl/send_request",
          data: {'email': email},
          options: Options(headers: {'authorization': 'Bearer $token'}));

      successSendRequest = true;
      messageSendRequest = response.data["message"];

      print("From ConnectionProvider response: ${response.data}");
    } on DioException catch (error) {
      if (error.response!.statusCode == 405) {
        successSendRequest = false;
        messageSendRequest = "Request already exists";
      } else if (error.response!.statusCode == 403) {
        successSendRequest = false;
        messageSendRequest = "Email doesn't exist";
      }
      print("From ConnectionProvider error: $error");
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

      sendResponseFail = false;

      /// rejecting a request
      ///
      if (response.data["request"]["status"] == "rejected") {
        listOfRequests?.removeWhere(
            (element) => element['id'] == response.data["request"]["id"]);
        // print("From provider: $listOfRequests");
        // print("From provider: ${listOfRequests?.length}");
        if (listOfRequests!.isEmpty) {
          noRequests = true;
        } else {
          noRequests = false;
        }
        notifyListeners();
      } else if (response.data["request"]["status"] == "accepted") {
        preferences = await SharedPreferences.getInstance();

        await preferences?.setString('connection_status', "true");

        print(
            "Provider in prefs ${preferences?.getString('connection_status')} ");
        notifyListeners();
      }
    } on DioException catch (error) {
      /// When i got error status 302,i'm not sure what the error is. I refresh cntrl + s in connection provider and it works
      print(error);
      if (error.response?.statusCode == 302) {
        sendResponseFail = true;
        failedResponseMessage =
            "Connection error occured, please try again later";
      }
    }
  }

  /// Display user's partners
  ///
  getPartners(token) async {
    final baseUrl = Requests.baseUrl;
    final dio = Dio();

    try {
      final response = await dio.get("$baseUrl/display_history",
          options: Options(headers: {"authorization": "Bearer $token"}));

      // listOfPartners = response.data["connections"];
      print(response.data);
    } on DioException catch (error) {
      print(error);
    }
  }
}
