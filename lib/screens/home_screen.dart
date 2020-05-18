import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_dc_app/models/user_model.dart';

import '../http/types.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  BasicCourseInfo actualCourse;

  Future<List<BasicCourseInfo>> getCourses(BuildContext context) async {
    List<BasicCourseInfo> coursesList =
        await Provider.of<User>(context, listen: false).getCourses();

    return coursesList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BasicCourseInfo>>(
      future:
          getCourses(context), // a previously-obtained Future<String> or null
      builder: (BuildContext context,
          AsyncSnapshot<List<BasicCourseInfo>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[];
          snapshot.data.forEach(
            (courseObj) {
              children.add(
                ListTile(
                  title: Text(courseObj.name),
                  onTap: () {
                    setState(() {
                      actualCourse = courseObj;
                    });
                  },
                ),
              );
            },
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
              child: Text('Loading User Data...'),
            )
          ];
        }
        children.add(
          FlatButton(
            onPressed: () {
              _logout();
            },
            child: Text('Logout'),
          ),
        );
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                Provider.of<User>(context, listen: false).addNewCouse();
                },
              ),
              // action button
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('MENU'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Reset Database'),
                  onTap: () {
                    Provider.of<User>(context, listen: false).resetDB();
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Provider.of<User>(context, listen: false).changeLoggedStatus(false);
    Navigator.pushReplacementNamed(context, "/");
  }
}
