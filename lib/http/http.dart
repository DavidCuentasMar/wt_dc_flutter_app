import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:wt_dc_app/http/types.dart";

const String BASE = "https://movil-api.herokuapp.com";

Future<AuthResponse> signIn({String email, String password}) async {
  var response = await http.post("$BASE/signin",
      body: jsonEncode({'email': email, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode != 200) throw Exception(response.body);
  return AuthResponse.fromJson(jsonDecode(response.body));
}

Future<AuthResponse> signUp(
    {String email, String password, String username, String name}) async {
  var response = await http.post("$BASE/signup",
      body: jsonEncode({'email': email, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode != 200) throw Exception(response.body);
  return AuthResponse.fromJson(jsonDecode(response.body));
}

Future<CheckTokenResponse> checkToken(String token) async {
  var response = await http.post("$BASE/check/token", headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  return CheckTokenResponse.fromJson(jsonDecode(response.body));
}
