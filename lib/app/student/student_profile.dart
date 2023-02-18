import 'package:flutter/material.dart';
import 'package:student_attendance/main.dart';
import 'package:student_attendance/connection/login_data_function.dart';
import '../../connection/crud.dart';
import '../componants/profile_Builder.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> with Crud {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
      future: getStudentData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Stack(
            children: [
              BasicScaffold(size: _size),
              UserDataColumn(
                size: _size,
                username: sharedPref.getString("student_name").toString(),
                useremail: sharedPref.getString("email").toString(),
              ),
            ],
          );
        } else {
          return Center(child: Text('loading'));
        }
      },
    );
  }
}
