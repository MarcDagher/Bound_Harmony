class User {
  final String username;
  final String email;
  final String password;
  final String birthdate;
  final String? location;
  final String image;
  final String connectionStatus;
  final String coupleSurveyStatus;

  User({
    required this.email,
    required this.username,
    required this.password,
    this.birthdate = "15-01-2003",
    this.image = "no image",
    this.location,
    this.connectionStatus = "false",
    this.coupleSurveyStatus = "uncompleted",
  });
}
