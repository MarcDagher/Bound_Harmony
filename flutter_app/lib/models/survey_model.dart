class Question {
  final int id;
  final String question;
  final List options;
  final String type;

  Question(
      {required this.id,
      required this.options,
      required this.question,
      required this.type});
}

class Response {
  final int questionId;
  String response;

  Response({required this.questionId, required this.response});
}

class CoupleSurveyResponse {
  final int questionId;
  String? response;
  List<String>? checkboxes;
  List<bool?>? isChecked;
  CoupleSurveyResponse(
      {required this.questionId,
      this.response,
      this.checkboxes,
      this.isChecked});
}
