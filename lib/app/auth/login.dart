import 'package:flutter/material.dart';
import 'package:student_attendance/app/componants/custom_app_bar.dart';
import 'package:student_attendance/app/componants/error_dialog.dart';
import 'package:student_attendance/app/componants/text_form_field.dart';
import 'package:student_attendance/connection/crud.dart';
import 'package:student_attendance/app/componants/valid.dart';
import 'package:student_attendance/constant/linkapi.dart';
import 'package:student_attendance/constant/styles.dart';
import 'package:student_attendance/main.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? accountType;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud _crud = Crud();
  bool isLoading = false;

  login() async {
    if (formstate.currentState!.validate()) {
      if (accountType != null) {
        isLoading = true;
        setState(() {});
        var responce = await _crud.postRequest(
          accountType!,
          {"id": id.text, "password": password.text},
        );
        isLoading = false;
        setState(() {});

        sharedPref.setString("accountType", accountType.toString());
        if (await responce['status'] == "success") {
          if (accountType == linkStudentLogin) {
            sharedPref.setString(
                "id", responce["data"]["student_id"].toString());
            sharedPref.setString(
                "password", responce["data"]["password"].toString());
            sharedPref.setString("initialroute", "student_profile");
            Navigator.of(context)
                .pushNamedAndRemoveUntil("student_profile", (route) => false);
          }
          if (accountType == linkDoctorLogin) {
            sharedPref.setString(
                "id", responce["data"]["doctor_id"].toString());
            sharedPref.setString(
                "password", responce["data"]["password"].toString());
            sharedPref.setString("initialroute", "doctor_profile");
            Navigator.of(context)
                .pushNamedAndRemoveUntil("doctor_profile", (route) => false);
          }
        } else {
          errorDialog('Id or Password is wrong', context);
        }
      } else {
        errorDialog('Choose Account type', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(gradient: primaryGradient),
        child: Center(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: size.height * 2 / 3 + 20,
                  width: size.width - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(130),
                          topRight: Radius.circular(130))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formstate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/HTI_Logo.png",
                              height: size.height / 4,
                            ),
                            SizedBox(height: 10),
                            CustTextForm(
                              valid: (val) {
                                return validInput(val!, 3, 50);
                              },
                              mycontroller: id,
                              hint: "User Id",
                            ),
                            CustTextForm(
                              valid: (val) {
                                return validInput(val!, 3, 50);
                              },
                              mycontroller: password,
                              hint: 'Password',
                            ),
                            SizedBox(height: 10),
                            RadioListTile(
                              title: Text("Doctor"),
                              value: linkDoctorLogin,
                              groupValue: accountType,
                              onChanged: (value) {
                                setState(() {
                                  accountType = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Student"),
                              value: linkStudentLogin,
                              groupValue: accountType,
                              onChanged: (value) {
                                setState(() {
                                  accountType = value.toString();
                                });
                              },
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.symmetric(
                                horizontal: 70,
                              ),
                              child: Text('log in'),
                              color: primaryColor,
                              textColor: backGroundColor,
                              onPressed: () async {
                                await login();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
