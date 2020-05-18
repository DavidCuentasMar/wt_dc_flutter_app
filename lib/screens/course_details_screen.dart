import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseId;
  
  const CourseDetailsScreen ({ Key key, this.courseId }): super(key: key);

  CourseDetailsScreenState createState() => CourseDetailsScreenState();
}

class CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Text('UPA');
  }
}