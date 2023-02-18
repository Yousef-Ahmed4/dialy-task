import 'package:flutter/material.dart';
import 'package:student_attendance/app/auth/login.dart';
import 'package:student_attendance/app/componants/schedule_Builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/doctor/reports/attendance_reports.dart';
import 'app/doctor/doctor_profile.dart';
import 'app/doctor/qr_generator.dart';
import 'app/doctor/reports/report.dart';
import 'app/student/qr_reader.dart';
import 'app/student/student_profile.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Attendance',
      initialRoute: sharedPref.getString("id") == null
          ? "login"
          : sharedPref.getString("initialroute"),
      routes: {
        "login": (context) => LogIn(),
        "schedule": (context) => SchedulePage(),
        "qr_generator": (context) => QrGenerator(),
        "qr_reader": (context) => QrReader(),
        "doctor_profile": (context) => DoctorProfile(),
        "student_profile": (context) => StudentProfile(),
        "attendace_report": (context) => AttendaceReports(),
        "report": (context) => Report(),
      },
    );
  }
}
