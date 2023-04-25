import 'package:dhaxalxisaab/home.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
// import 'design2.dart';
// import 'start.dart';
import 'package:flutter/services.dart';
import 'marxuum.dart';
import 'dhaxlayaal.dart';
import 'login.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: MyLogin(),
    ),
  ));
}

class AppColors {
  static final Color backgroundColor = Color(0xFFEDE7F6);
  static final Color mainColor = Color.fromARGB(255, 172, 138, 221);
}
