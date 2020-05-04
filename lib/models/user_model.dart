import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:wt_dc_app/http/http.dart";
import 'package:wt_dc_app/http/types.dart';

class User extends ChangeNotifier {
  String _email;
  String _password;
  String _username;
  String _name;
  String _token;
  bool _isLogged;

  User(this._email, this._password, this._isLogged);

  void logIn(String email, String password) async {
    try {
      AuthResponse userInfo = await signIn(email: email, password: password);
      this._email = userInfo.email;
      this._password = password;
      this._isLogged = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('WT_DC_EMAIL', userInfo.email);
      prefs.setString('WT_DC_PASSWORD', password);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void register(
      String email, String password, String username, String name) async {
    try {
      AuthResponse userInfo = await signUp(
          email: email, password: password, username: username, name: name);

      this._email = userInfo.email;
      this._password = password;
      this._username = username;
      this._name = name;
      this._token = userInfo.token;
      this._isLogged = true;

      print('USER REGISTER FROM CONTROLLER');
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('WT_DC_EMAIL', email);
      prefs.setString('WT_DC_PASSWORD', password);
      prefs.setString('WT_DC_TOKEN', userInfo.token);
      prefs.setString('WT_DC_USERNAME', username);
      prefs.setString('WT_DC_NAME', name);
      notifyListeners();
    } catch (e) {
      print(e);
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
