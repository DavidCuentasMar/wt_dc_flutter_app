import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_dc_app/models/user_model.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = new TextEditingController();
  final controllerPass = new TextEditingController();
  final controllerUsername = new TextEditingController();
  final controllerName = new TextEditingController();

  Future<User> loadUser() async {
    var userObj = User('', '', false);
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('WT_DC_EMAIL');
    final password = prefs.getString('WT_DC_PASSWORD');
    if (email != null && password != null) {
      userObj = User(email, password, true);
    }
    await new Future.delayed(const Duration(seconds: 5));
    return userObj;
  }

  //@override
  //void initState() {
//    super.initState();
  //  WidgetsBinding.instance
  //    .addPostFrameCallback((_) => _authentication("", "", "", "", true));
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                    controller: controllerEmail,
                    validator: (value) {
                      if (value.isEmpty) return 'Please, enter an email!';
                      return null;
                    }),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerPass,
                  validator: (value) {
                    if (value.isEmpty) return 'Please, enter a password!';
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerUsername,
                  validator: (value) {
                    if (value.isEmpty) return 'Please, enter an username!';
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerName,
                  validator: (value) {
                    if (value.isEmpty) return 'Please, enter an name!';
                    return null;
                  },
                ),
              ),
              FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      String email = controllerEmail.text;
                      String password = controllerPass.text;
                      String username = controllerPass.text;
                      String name = controllerPass.text;
                      //controllerPass.clear();
                      //controllerEmail.clear();
                      //controllerUsername.clear();
                      //controllerName.clear();
                      _authentication(email, password, username, name, false);
                    }
                  },
                  child: Text('Sign up')),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/signin", (_) => false);
                  },
                  child: Text('Sign in'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _authentication(String email, String password, String username,
      String name, bool fromInit) async {
    Provider.of<User>(context, listen: false)
        .register(email, password, username, name);
    Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
  }
}
