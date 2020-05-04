import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:wt_dc_app/http/types.dart";

const String BASE = "https://movil-api.herokuapp.com";

Future<SignInResponse> signIn({String email, String password}) async {
  final http.Response response = await http.post("$BASE/signin",
      body: jsonEncode({'email': email, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {
    return SignInResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

Future signUp() {}

Future checkToken() {}
