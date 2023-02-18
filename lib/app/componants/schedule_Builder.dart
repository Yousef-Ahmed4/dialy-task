import 'package:flutter/material.dart';
import 'package:student_attendance/app/componants/custom_app_bar.dart';
import 'package:student_attendance/constant/styles.dart';
import '../../constant/linkapi.dart';
import '../../connection/get_data.dart';
import '../../main.dart';
import 'cardnote.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String scheduleNum = "0";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('My Schedule', context),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: primaryGradient),
            // margin: EdgeInsets.all(10),
          ),
          Column(
            children: [
              Container(
                width: size.width - 10,
                height: size.height * 2 / 3,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: 10,
                  bottom: 50,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: getData(
                          sharedPref.getString("accountType") ==
                                  linkStudentLogin
                              ? linkStudentSchedule
                              : linkDoctorSchedule,
                          sharedPref.getString("id").toString(),
                        ),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data["status"] == 'fail') {
                              return Center(
                                  child: Text(
                                'no data',
                                style: TextStyle(fontSize: 23),
                              ));
                            } else {
                              scheduleNum =
                                  snapshot.data['data'].length.toString();
                              return ListView.builder(
                                  itemCount: snapshot.data['data'].length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return CardNotes(
                                      content:
                                          'Group ${snapshot.data['data'][i]['group_number']}',
                                      title:
                                          '${snapshot.data['data'][i]['course_name']}',
                                      time:
                                          'time (${snapshot.data['data'][i]['time']})',
                                      ontap: sharedPref
                                                  .getString("accountType") ==
                                              linkDoctorLogin
                                          ? () {
                                              sharedPref.setString(
                                                  "current_schedule",
                                                  '${snapshot.data['data'][i]['schedule_id']}');
                                              sharedPref.setString(
                                                  "course_name",
                                                  '${snapshot.data['data'][i]['course_name']}');
                                              sharedPref.setString(
                                                  "group_number",
                                                  '${snapshot.data['data'][i]['group_number']}');
                                              Navigator.of(context)
                                                  .pushNamed("qr_generator");
                                            }
                                          : () {},
                                    );
                                  });
                            }
                          }

                          return Center(child: Text('no data...'));
                        },
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Schedule \n Goals",
                    style: titleTextStyle.copyWith(color: backGroundColor),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  InkWell(
                    onTap: () => setState(() {}),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4.0, color: backGroundColor),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FutureBuilder(
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Text(
                              scheduleNum,
                              style: titleTextStyle.copyWith(
                                  color: backGroundColor),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
