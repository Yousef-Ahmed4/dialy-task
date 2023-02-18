import 'package:flutter/material.dart';
import 'package:student_attendance/main.dart';
import 'package:student_attendance/connection/login_data_function.dart';
import '../../connection/crud.dart';
import '../componants/profile_Builder.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> with Crud {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
      future: getDoctorData(),
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
                username:
                    "Dr." + sharedPref.getString("doctor_name").toString(),
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
