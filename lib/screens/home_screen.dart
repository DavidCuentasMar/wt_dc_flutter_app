import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_dc_app/models/user_model.dart';

import '../http/types.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<List<BasicCourseInfo>> getCourses() async {
    List<BasicCourseInfo> coursesList= List<BasicCourseInfo>();    
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 1',professor:'A',students:1));
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 2',professor:'A',students:1));
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 3',professor:'A',students:1));
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 4',professor:'A',students:1));
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 5',professor:'A',students:1));
    coursesList.add(BasicCourseInfo(id:1,name:'CALSE 6',professor:'A',students:1));

     await Future.delayed(Duration(seconds: 2));
    return coursesList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BasicCourseInfo>>(
      future: getCourses(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<BasicCourseInfo>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[];
          snapshot.data.forEach(
            (courseObj) {
              children.add(
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(courseObj.name),
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
