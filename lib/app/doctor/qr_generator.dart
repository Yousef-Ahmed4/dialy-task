import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:student_attendance/app/componants/error_dialog.dart';
import 'package:student_attendance/app/componants/valid.dart';
import 'package:student_attendance/connection/crud.dart';
import 'package:student_attendance/constant/linkapi.dart';
import 'package:student_attendance/constant/styles.dart';
import 'package:student_attendance/main.dart';

import '../componants/text_form_field.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator({Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController sessionNum = TextEditingController();
  bool isLoading = false;
  String? qrData;
  bool showQR = false;
  getQr() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var responce = await Crud().postRequest(
        linkNewSession,
        {
          "schedule_id": sharedPref.getString("current_schedule").toString(),
          "session_num": sessionNum.text,
        },
      );
      isLoading = false;
      setState(() {});
      if (await responce['status'] == "success") {
        String sessionId = sharedPref.getString("current_schedule").toString() +
            "_" +
            sessionNum.text;

        setState(() {
          qrData = sessionId;
        });
      } else {
        errorDialog('the session alredy exist', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            sharedPref.remove("course_name");
            sharedPref.remove("group_number");
            sharedPref.remove("current_schedule");
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        title: Text(
          sharedPref.getString("course_name").toString() +
              " G-" +
              sharedPref.getString("group_number").toString(),
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width - 50,
          margin: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
          child: qrData == null
              ? Form(
                  key: formstate,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: CustTextForm(
                            valid: (val) {
                              return validInput(val!, 1, 20);
                            },
                            mycontroller: sessionNum,
                            hint: "Session Number "),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.symmetric(
                          horizontal: 70,
                        ),
                        child: Text('get QR'),
                        color: primaryColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          await getQr();
                        },
                      ),
                    ],
                  ),
                )
              : Center(child: QrCode(data: qrData)),
        ),
      ),
    );
  }
}

class QrCode extends StatelessWidget {
  final String? data;
  const QrCode({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: data!,
      version: QrVersions.auto,
      size: 300.0,
    );
  }
}
