import 'package:flutter/material.dart';
import 'package:student_attendance/constant/styles.dart';

import '../../../connection/get_data.dart';
import '../../../constant/linkapi.dart';
import '../../../main.dart';
import '../../componants/custom_app_bar.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          sharedPref.getString("course_name").toString() +
              " group: " +
              sharedPref.getString("group_number").toString(),
          context),
      body: Container(
        decoration: BoxDecoration(gradient: primaryGradient),
        child: ListView(
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Id",
                          style: titleTextStyle.copyWith(fontSize: 22),
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Name",
                          style: titleTextStyle.copyWith(fontSize: 22),
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Attendance",
                          style: titleTextStyle.copyWith(fontSize: 22),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder(
                  future: getData(linkAttendanceReport,
                      sharedPref.getString("current_schedule").toString()),
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
                      return Table(
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: List<TableRow>.generate(
                          snapshot.data['data'].length,
                          (index) {
                            final student = snapshot.data['data'][index];
                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(student["student_id"].toString(),
                                      style: subTitleTextStyle,
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      student["student_name"].toString(),
                                      style: subTitleTextStyle,
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      student["student_attendance"].toString(),
                                      style: subTitleTextStyle,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            );
                          },
                          growable: false,
                        ),
                      );
                    } else {
                      return Center(child: Text('no data...'));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}



  // return Table(
  //                   defaultColumnWidth: FixedColumnWidth(120.0),
  //                   border: TableBorder.all(
  //                       color: Colors.black,
  //                       style: BorderStyle.solid,
  //                       width: 2),
  //                   children: List<TableRow>.generate(
  //                     _studentList.length,
  //                     (index) {
  //                       final student = _studentList[index];
  //                       return TableRow(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.all(5.0),
  //                             child: Text(student.id.toString(),
  //                                 textAlign: TextAlign.center),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.all(5.0),
  //                             child: Text(student.name,
  //                                 textAlign: TextAlign.center),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.all(5.0),
  //                             child: Text(student.email,
  //                                 textAlign: TextAlign.center),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.all(5.0),
  //                             child: Text(student.phone,
  //                                 textAlign: TextAlign.center),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                     growable: false,
  //                   ),
                    // [
                    //   TableRow(children: [
                    //     Column(children: [
                    //       Text('Student Id', style: TextStyle(fontSize: 20.0))
                    //     ]),
                    //     Column(children: [
                    //       Text('Name', style: TextStyle(fontSize: 20.0))
                    //     ]),
                    //     Column(children: [
                    //       Text('Attendance', style: TextStyle(fontSize: 20.0))
                    //     ]),
                    //   ]),
                    //   TableRow(children: [
                    //     // Column(children: []),
                    //     Center(heightFactor: 2, child: Text('Javatpoint')),
                    //     Center(heightFactor: 2, child: Text('Flutter')),
                    //     Center(heightFactor: 2, child: Text('5*')),
                    //   ]),
                    //   TableRow(children: [
                    //     Column(children: [Text('Javatpoint')]),
                    //     Column(children: [Text('MySQL')]),
                    //     Column(children: [Text('5*')]),
                    //   ]),
                    //   TableRow(children: [
                    //     Column(children: [Text('Javatpoint')]),
                    //     Column(children: [Text('ReactJS')]),
                    //     Column(children: [Text('5*')]),
                    //   ]),
                    // ],
                  // );
               