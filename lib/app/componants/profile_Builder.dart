import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_attendance/constant/styles.dart';
import 'package:student_attendance/main.dart';

class BasicScaffold extends StatelessWidget {
  const BasicScaffold({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Container(
        height: _size.height * 3 / 10,
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(_size.height / 9),
          ),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "My Profile",
              style:
                  titleTextStyle.copyWith(color: Colors.black87, fontSize: 20),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(child: Row()),
            InkWell(
              onTap: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      sharedPref.clear();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("login", (route) => false);
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Logout",
                    style: subTitleTextStyle,
                  )
                ],
              ),
            ),
            Expanded(child: Row()),
          ],
        ),
      ),
    );
  }
}

class UserDataColumn extends StatelessWidget {
  const UserDataColumn({
    Key? key,
    required Size size,
    required var username,
    required String useremail,
  })  : _size = size,
        userName = username,
        userEmail = useremail,
        super(key: key);

  final Size _size;
  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: CircleAvatar(
            radius: _size.height / 7,
            backgroundImage: AssetImage("assets/user1.jpg"),
          ),
        ),
        DefaultTextStyle(
          child: Text(userName),
          style: titleTextStyle,
        ),
        SizedBox(
          height: 10,
        ),
        DefaultTextStyle(
          child: Text(userEmail),
          style: subTitleTextStyle,
        ),
        SizedBox(
          height: 40,
        ),
        sharedPref.getString("student_name") == null
            ? ProfileOptions(
                onPress: "attendace_report",
                size: _size,
                icon: Icons.grid_on_outlined,
                titel: "grades",
              )
            : ProfileOptions(
                onPress: "qr_reader",
                size: _size,
                icon: Icons.table_chart,
                titel: "My Attendance",
              ),
        ProfileOptions(
          onPress: "schedule",
          size: _size,
          icon: Icons.table_rows,
          titel: "Schedule ",
        ),
        sharedPref.getString("student_name") == null
            ? ProfileOptions(
                onPress: "attendace_report",
                size: _size,
                icon: Icons.adf_scanner_sharp,
                titel: "Attendance Report",
              )
            : ProfileOptions(
                onPress: "qr_reader",
                size: _size,
                icon: Icons.data_saver_on,
                titel: "Attendance",
              ),
      ],
    );
  }
}

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    Key? key,
    required Size size,
    required this.titel,
    required this.icon,
    required this.onPress,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final String onPress;
  final String titel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: _size.width - 50,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black12),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushNamed(onPress);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black54,
              ),
              SizedBox(
                width: 7,
              ),
              DefaultTextStyle(
                child: Text(
                  titel,
                ),
                style: subTitleTextStyle,
              ),
              Expanded(
                child: Row(),
              ),
              SvgPicture.asset(
                "assets/right_arrow_ic.svg",
                color: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
