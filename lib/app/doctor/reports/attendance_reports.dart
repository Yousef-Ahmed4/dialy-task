import 'package:flutter/material.dart';
import 'package:student_attendance/app/componants/custom_app_bar.dart';
import 'package:student_attendance/constant/styles.dart';
import '../../../constant/linkapi.dart';
import '../../../connection/get_data.dart';
import '../../../main.dart';
import '../../componants/cardnote.dart';

class AttendaceReports extends StatefulWidget {
  const AttendaceReports({Key? key}) : super(key: key);

  @override
  State<AttendaceReports> createState() => _AttendaceReportsState();
}

class _AttendaceReportsState extends State<AttendaceReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Attendace Reports', context),
      body: Container(
        decoration: BoxDecoration(gradient: primaryGradient),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getData(
                  sharedPref.getString("accountType") == linkStudentLogin
                      ? linkStudentSchedule
                      : linkDoctorSchedule,
                  sharedPref.getString("id").toString(),
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == 'fail')
                      return Center(
                          child: Text(
                        'no data',
                        style: TextStyle(fontSize: 23),
                      ));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            content:
                                'Group ${snapshot.data['data'][i]['group_number']}',
                            title: '${snapshot.data['data'][i]['course_name']}',
                            time: '${snapshot.data['data'][i]['time']}',
                            ontap: sharedPref.getString("accountType") ==
                                    linkDoctorLogin
                                ? () {
                                    sharedPref.setString("current_schedule",
                                        '${snapshot.data['data'][i]['schedule_id']}');

                                    sharedPref.setString("course_name",
                                        '${snapshot.data['data'][i]['course_name']}');

                                    sharedPref.setString("group_number",
                                        '${snapshot.data['data'][i]['group_number']}');

                                    Navigator.of(context).pushNamed("report");
                                  }
                                : () {},
                          );
                        });
                  }
                  return Center(child: Text('is loading...'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
