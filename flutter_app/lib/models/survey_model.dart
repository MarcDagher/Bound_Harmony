class Question {
  final int id;
  final String question;
  final List options;

  Question({required this.id, required this.options, required this.question});
  // // override the toString method to print the questions on console
  // @override
  // String toString() {
  //   return "Question(id: $id, question: $question, options: $options)";
  // }
}

class Response {
  final int questionId;
  final String response;

  Response({required this.questionId, required this.response});
}
