import 'package:flutter/material.dart';

TextStyle titleTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

TextStyle subTitleTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 17,
  fontWeight: FontWeight.w400,
);

Color primaryColor = Colors.blue.shade700;
Color backGroundColor = Colors.white;

Gradient primaryGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.2, 0.4, 0.7, 0.9],
  colors: [
    Colors.blue.shade200,
    Colors.blue.shade500,
    Colors.blue.shade700,
    Colors.blue.shade800,
  ],
);
