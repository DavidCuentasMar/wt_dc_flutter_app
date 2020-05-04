import 'package:http/http.dart' as http;
import "package:wt_dc_app/http/types.dart";

const String BASE = "https://movil-api.herokuapp.com";

Future<SignInResponse> signIn({String email, String password}) async {
  final http.Response response =
      await http.post("$BASE/signin", body: {email: email, password: password});

  print(response.body);
}

Future signUp() {}

Future checkToken() {}
