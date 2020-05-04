import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class SignInScreen extends StatefulWidget {
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = new TextEditingController();
  final controllerPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        child: Container(
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
                FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        String email = controllerEmail.text;
                        String password = controllerPass.text.toString();
                        //controllerPass.clear();
                        //controllerEmail.clear();
                        _saveNewUser(email, password);
                      }
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveNewUser(String email, String password) async {
    Provider.of<User>(context, listen: false).logIn(email, password);
    Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
  }
}
