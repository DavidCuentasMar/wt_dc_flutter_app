import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_dc_app/models/user_model.dart';
import 'package:wt_dc_app/screens/auth_screen.dart';
import 'package:wt_dc_app/screens/home_screen.dart';

import 'screens/sign_in_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<User> loadUser() async {
    var userObj = User('', '', '', false);
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('WT_DC_EMAIL');
    String password = prefs.getString('WT_DC_PASSWORD');
    String token = prefs.getString('WT_DC_TOKEN');
    String username = prefs.getString('WT_DC_USERNAME');

    print('loadUser - main.dart');
    print(email);
    if (email != null && password != null && token != null && username != null) {
      userObj = User(email, password, token, true);
      userObj.username = username;
    }
    await new Future.delayed(const Duration(seconds: 5));
    return userObj;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: loadUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return ChangeNotifierProvider<User>(
            create: (context) => snapshot.data,
            child: Consumer<User>(
              builder: (context, currentUser, child) {
                print('currentUser');
                print(currentUser);
                print(currentUser.isLogged);
                currentUser.isLogged ? print('A') : print('B');

                return MaterialApp(
                  title: "Login",
                  initialRoute: '/',
                  routes: {
                    '/': (context) =>
                        currentUser.isLogged ? HomeScreen() : AuthScreen(),
                    '/home': (context) => HomeScreen(),
                    '/auth': (context) => AuthScreen(),
                    '/signin': (context) => SignInScreen()
                  },
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return MaterialApp(
          title: "",
          home: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
