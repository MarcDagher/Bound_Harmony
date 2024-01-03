class User {
  final String username;
  final String email;
  final String password;
  final String? location;
  final String image;
  final String connectionStatus;
  final String coupleSurveyStatus;

  User({
    required this.email,
    required this.username,
    required this.password,
    this.image = "no image",
    this.location,
    this.connectionStatus = "false",
    this.coupleSurveyStatus = "uncompleted",
  });
}
