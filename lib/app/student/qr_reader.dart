import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:student_attendance/app/componants/cardnote.dart';
import 'package:student_attendance/app/componants/error_dialog.dart';
import 'package:student_attendance/connection/crud.dart';
import 'package:student_attendance/constant/linkapi.dart';
import 'package:student_attendance/constant/styles.dart';
import 'package:student_attendance/main.dart';

class QrReader extends StatefulWidget {
  const QrReader({Key? key}) : super(key: key);

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  String? qrStr;
  String? courseName;
  String? groupNumber;
  String? sessionNum;
  String? doctorName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        title: Text(
          "Qr Reader",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          height: size.height * 3 / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              qrStr == null
                  ? ElevatedButton(
                      onPressed: scanQr,
                      child: Text(
                        ("Scann"),
                      ),
                    )
                  : FutureBuilder(
                      future: sessionData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(15),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          ("Session Data "),
                                          style: titleTextStyle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ("Course Name : " + courseName!),
                                          style: subTitleTextStyle,
                                        ),
                                        Text(("Group : " + groupNumber!),
                                            style: subTitleTextStyle),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(("Session : " + sessionNum!),
                                            style: subTitleTextStyle),
                                        Text(("Doctor : " + doctorName!),
                                            style: subTitleTextStyle),
                                      ],
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await confirm();
                                  },
                                  child: Text(
                                    ("confirm"),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: scanQr,
                                  child: Text(
                                    ("Scann Again"),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        return Center(child: Text('is loading...'));
                      }),
            ],
          ),
        ),
      ),
    );
  }

  scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2a99cf", "cancel", true, ScanMode.QR)
          .then((value) {
        value =
            "5_1"; //TODO -Remove this line when you to Unset fixed value to the reader.
        setState(() {
          qrStr = value;
        });
      });
    } catch (e) {
      setState(() {
        errorDialog('"unable to read this"', context);
      });
    }
  }

  confirm() async {
    var responce = await Crud().postRequest(
      linkNewStudentAttendance,
      {
        "student_id": sharedPref.getString("id").toString(),
        "session_id": qrStr.toString(),
      },
    );
    if (await responce['status'] == "success") {
      Navigator.of(context).pop();
    } else {
      errorDialog('you alredy added', context);
    }
  }

  sessionData() async {
    var responce = await Crud().postRequest(
      linkSessionData,
      {
        "session_id": qrStr.toString(),
      },
    );
    if (await responce['status'] == "success") {
      courseName = responce["data"]["course_name"].toString();
      groupNumber = responce["data"]["group_number"].toString();
      sessionNum = responce["data"]["session_num"].toString();
      doctorName = responce["data"]["doctor_name"].toString();
    } else {
      errorDialog('please scann again', context);
      // Navigator.of(context).pushNamed('qr_reader');
    }
    return responce;
  }
}
