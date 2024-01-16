import 'package:bound_harmony/configurations/request.configuration.dart';
import 'package:bound_harmony/models/message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesProvider extends ChangeNotifier {
  final _dio = Dio();
  bool? successSavingMessage;

  List<Message> conversation = [
    Message(
        text: "Hello, how can I help you?",
        date: DateTime.now(),
        isSentByMe: false)
  ];

  getHistoryOfMessages() {}

  sendMessage(Message userMessage) async {
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
        successSavingMessage = true;
        notifyListeners();
      }

      print("In sendMessage() response: ${response.data}");
    } on DioException catch (error) {
      print("In sendMessage() error: $error");
      successSavingMessage = false;
      notifyListeners();
    }
  }
}
