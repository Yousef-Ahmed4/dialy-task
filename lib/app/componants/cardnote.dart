import 'package:flutter/material.dart';
import 'package:student_attendance/constant/styles.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final String title;
  final String content;
  final String time;

  const CardNotes({
    Key? key,
    required this.ontap,
    required this.title,
    required this.content,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        shadowColor: primaryColor,
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text('$title'),
                subtitle: Text('$content'),
                trailing: Text("$time"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
