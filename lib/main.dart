import 'dart:convert';

import 'package:dhaxalxisaab/home.dart';
import 'package:dhaxalxisaab/insertuser.dart';
import 'package:flutter/material.dart';
import 'deceasePanel.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'masaxbaa.dart';
import 'result.dart';

final inheritance = calculateIslamicInheritance(
    100, 0, 0, 1, 2 / 3, 1 / 8, 0, 0, 0, 1 / 3, 0, 0);
final json = jsonEncode(
    inheritance.map((h) => {'name': h.name, 'share': h.share}).toList());
String g = jsonEncode(json);
void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: InheritanceScreen(
        jsonData: g,
      ),
    ),
  ));
}
