import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:wt_dc_app/http/types.dart";

const String BASE = "https://movil-api.herokuapp.com";

// AUTH

Future<AuthResponse> signIn({String email, String password}) async {
  var response = await http.post("$BASE/signin",
      body: jsonEncode({'email': email, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode != 200) {
    throw Exception(jsonDecode(response.body)["error"]);
  }

  return AuthResponse.fromJson(jsonDecode(response.body));
}

Future<AuthResponse> signUp(
    {String email, String password, String username, String name}) async {
  var response = await http.post("$BASE/signup",
      body: jsonEncode({
        'email': email,
        'password': password,
        'username': username,
        'name': name
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode != 200) {
    throw Exception(jsonDecode(response.body)["error"]);
  }

  return AuthResponse.fromJson(jsonDecode(response.body));
}

Future<CheckTokenResponse> checkToken(String token) async {
  var response = await http.post("$BASE/check/token", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  return CheckTokenResponse.fromJson(jsonDecode(response.body));
}

// COURSES

Future<bool> resetData(String token, String dbId) async {
  var response =
      await http.get("$BASE/$dbId/restart", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });
  print('asd');
  print(response.body);
  return false;
}

Future<List<BasicCourseInfo>> showCourses(String token, String dbId) async {
  var response =
      await http.get("$BASE/$dbId/courses", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode != 200) {
    throw Exception(jsonDecode(response.body)["error"]);
  }

  return (jsonDecode(response.body) as List).map((i) {
    return BasicCourseInfo.fromJson(i);
  }).toList();
}

Future<Course> getCourse(String token, String dbId, String id) async {
  var response = await http.get("$BASE/$dbId/$id", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode != 200) {
    throw Exception(jsonDecode(response.body)["error"]);
  }

  return Course.fromJson(jsonDecode(response.body));
}

Future<BasicCourseInfo> addCouse(String token, String dbId) async {
  var response =
      await http.post("$BASE/$dbId/courses", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode != 200) {
    throw Exception(jsonDecode(response.body)["error"]);
  }
  print(response.body);
  return BasicCourseInfo.fromJson(jsonDecode(response.body));
}
