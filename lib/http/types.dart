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
      students: json['students'],
    );
  }
}

class Course {
  String name;
  PersonBasicInfo professor;
  List<PersonBasicInfo> students;

  Course({this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      professor: PersonBasicInfo.fromJson(json['professor']),
      students: List<PersonBasicInfo>.from(json['students']),
    );
  }
}

class PersonBasicInfo {
  int id;
  String name;
  String username;
  String email;

  PersonBasicInfo({this.id, this.name, this.username, this.email});

  factory PersonBasicInfo.fromJson(Map<String, dynamic> json) {
    return PersonBasicInfo(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class PersonInfo {
  int courseId;
  String name;
  String username;
  String email;
  String phone;
  String city;
  String country;
  DateTime birthday;

  PersonInfo({
    this.courseId,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.city,
    this.birthday,
    this.country,
  });

  factory PersonInfo.fromJson(Map<String, dynamic> json) {
    return PersonInfo(
      courseId: json['course_id'],
      email: json['email'],
      birthday: DateTime(
        json['birthday'],
      ),
      city: json['city'],
      country: json['country'],
      name: json['name'],
      phone: json['phone'],
      username: json['username'],
    );
  }
}
