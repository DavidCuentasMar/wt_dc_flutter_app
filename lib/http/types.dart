class AuthResponse {
  String token;
  String username;
  String name;
  String email;

  AuthResponse({this.token, this.username, this.name, this.email});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
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
