class AuthResponse {
  String token;
  String username;
  String name;

  AuthResponse({this.token, this.username, this.name});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}

class CheckTokenResponse {
  bool valid;

  CheckTokenResponse({this.valid});

  factory CheckTokenResponse.fromJson(Map<String, dynamic> json) {
    return CheckTokenResponse(
      valid: json['valid'],
    );
  }
}
