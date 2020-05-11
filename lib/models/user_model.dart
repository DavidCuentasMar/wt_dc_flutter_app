import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:wt_dc_app/http/http.dart";
import 'package:wt_dc_app/http/types.dart';

class User extends ChangeNotifier {
  String _email;
  String _username;
  String _name;
  String _token;
  bool _isLogged;

  User(this._email, this._name, this._token, this._username, this._isLogged);

  void logIn(String email, String password, bool remember) async {
    try {
      AuthResponse userInfo = await signIn(email: email, password: password);
      this._email = userInfo.email;
      this._token = userInfo.token;
      this._username = userInfo.username;
      this._isLogged = true;

      if (remember) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('WT_DC_EMAIL', userInfo.email);
        prefs.setString('WT_DC_TOKEN', userInfo.token);
        prefs.setString("WT_DC_NAME", userInfo.name);
        prefs.setString('WT_DC_USERNAME', userInfo.username);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void resetDB() async {
    try {
      bool resetDb = await resetData(this._token, this._username);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
    void addNewCouse() async {
    try {
      BasicCourseInfo newCourse = await addCouse(this._token, this._username);
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
      this._username = username;
      this._name = name;
      this._token = userInfo.token;
      this._isLogged = true;

      print('USER REGISTER FROM CONTROLLER');
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('WT_DC_EMAIL', email);
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

  Future<List<BasicCourseInfo>> getCourses() async {
    print('asf');
    try {
      print('GET COURSES - TOKEN');
      print(this._token);
      print(this._username);

      return showCourses(this._token, this._username);
    } catch (e) {
      print(e);
    }
  }

  bool get isLogged => _isLogged;
  String get name => _name;
  String get email => _email;

  set username(String username) {
    this._username = username;
  }
}
