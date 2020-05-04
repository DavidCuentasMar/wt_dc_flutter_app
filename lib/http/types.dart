class SignInResponse {
  String token;
  String username;
  String name;

  SignInResponse({this.token, this.username, this.name});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}
