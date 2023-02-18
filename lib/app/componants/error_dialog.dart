import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog errorDialog(String msg, BuildContext context) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.rightSlide,
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(msg),
      ),
    ),
  )..show();
}
