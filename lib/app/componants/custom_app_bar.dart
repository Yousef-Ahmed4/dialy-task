import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

appBar(String title, context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.blue.shade200,
    ),
    elevation: 0,
    backgroundColor: Colors.blue.shade200,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black54,
      ),
    ),
  );
}
