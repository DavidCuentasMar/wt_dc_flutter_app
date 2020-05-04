import 'package:flutter/material.dart';
import "package:wt_dc_app/http/http.dart";
import 'package:wt_dc_app/http/types.dart';

class User extends ChangeNotifier {
  String _email;
  String _password;
  bool _isLogged;

  User(this._email, this._password, this._isLogged);

  void logIn(String email, String password) async {
    try {
      AuthResponse userInfo = await signIn(email: email, password: password);

      this._email = userInfo.email;
      this._isLogged = true;

      print('USER LOGIN FROM CONTROLLER');
      notifyListeners();
    } catch (e) {
      // Error
    }
  }

  void changeLoggedStatus(bool isLogged) {
    this._isLogged = isLogged;
    notifyListeners();
  }

  bool userExists(String email, String password) {
    return this._email == email && this._password == password;
  }

  bool get isLogged => _isLogged;

  String get email => _email;

  String get password => _password;
}
