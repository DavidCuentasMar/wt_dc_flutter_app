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

class BasicCourseInfo {
  int id;
  String name;
  String professor;
  int students;

  BasicCourseInfo({this.id, this.name, this.professor, this.students});

  factory BasicCourseInfo.fromJson(Map<String, dynamic> json) {
    return BasicCourseInfo(
        id: json['id'],
        name: json['name'],
        professor: json['professor'],
        students: json['students']);
  }
}
