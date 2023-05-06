import 'dart:convert';

import 'package:dhaxalxisaab/home.dart';
import 'package:dhaxalxisaab/insertuser.dart';
import 'package:dhaxalxisaab/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'deceasePanel.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'home.dart';
import 'dhaxlayaal.dart';
import 'result.dart';
import 'insertheirs.dart';
import 'register.dart';
void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: MyLogin(),
    ),
  ));
}
