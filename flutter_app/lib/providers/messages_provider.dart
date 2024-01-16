import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesProvider extends ChangeNotifier {
  final _dio = Dio();
  String somethingWentWrong = "";

  List<Message> conversation = [
    Message(
        text: "Hello, how can I help you?",
        date: DateTime.now(),
        isSentByMe: false)
  ];

  // fetch get_conversation -- NOT TESTED -
  Future getConversation() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.post(
        '${Requests.baseUrl}/get_conversation',
        options: Options(headers: {"authorization": "Bearer $token"}),
      );
      if (response.data['status'] == "success") {
        print("In successful, conversation: ${response.data["conversation"]}");
      }
      print("In getConversation: ${response.data}");
    } on DioException catch (error) {
      print("In getConversation: $error");
    }
  }

  Future sendMessage(Message userMessage) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token');
    try {
      final response = await _dio.post(
        '${Requests.baseUrl}/save_user_prompt',
        data: {"prompt": userMessage.text},
        options: Options(headers: {"authorization": "Bearer $token"}),
      );
      if (response.data["status"] == "success") {
        conversation.add(userMessage);
        notifyListeners();
      }

      print("In sendMessage() response: ${response.data}");
    } on DioException catch (error) {
      print("In sendMessage() error: $error");
      somethingWentWrong = "Something went worng, please try sending again";
      notifyListeners();
    }
  }
}
