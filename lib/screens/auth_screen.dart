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
    var userObj = User('', '', '', '', false);
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('WT_DC_NAME');
    String email = prefs.getString('WT_DC_EMAIL');
    String token = prefs.getString('WT_DC_TOKEN');
    String username = prefs.getString('WT_DC_USERNAME');

    if (email != null && username != null && token != null && name != null) {
      userObj = User(name, email, token, username, true);
    }

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
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value.isEmpty) return 'Please, enter an email!';
                      return null;
                    }),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerPass,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please, enter a password!';
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerUsername,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please, enter an username!';
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controllerName,
                  decoration: InputDecoration(labelText: 'Name'),
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/signin", (_) => false);
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
