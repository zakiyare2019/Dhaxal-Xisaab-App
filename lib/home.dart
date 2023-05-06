import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'deceasePanel.dart';
import 'heirsPanel.dart';
import 'masaxbaa.dart';
import 'result.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List jawaab = [];

  Future<void> goId() async {
    final _url =
        Uri.parse("http://192.168.32.2/inheritance_api/calculating.php");
    final _result =
        await http.post(_url, body: {"deceased_id": '3'}).catchError((e) {
      print('Cache Error: ' + e.toString());
    });
    // debugPrint(_result.statusCode.toString());
    jawaab = jsonDecode(_result.body);
    jawaab.removeAt(0);
  }

  @override
  void initState() {
    super.initState();
    goId();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.only(top: 250),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 18),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: marxuumClass(),
                    ),
                  ),
                );
              },
              child: Text("Marxuum"),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 20, left: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 24),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: MyApp(),
                    ),
                  ),
                );
              },
              child: Text("dhaxlayaal"),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              width: double.infinity,
              child: TextFormField(
                  decoration: InputDecoration(
                hintText: 'Gali Number',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  // borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ))),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 18),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              onPressed: () {
                // 
              },
              child: Text("qeebinta dhaxalka"),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          // Container(
          //     width: double.infinity,
          //     margin: EdgeInsets.only(right: 20, left: 20),
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //               RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(30.0),
          //                   side: BorderSide(color: Colors.red)))),
          //       onPressed: () {
          //
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) =>
//  MaterialApp(
          //               debugShowCheckedModeBanner: false,
          //               home: Scaffold(body: Container(child: home_page())),
          //             ),
          //           ),
          //         );
          //       },
          //       child: Text("Daabaco"),
          //     ))
        ],
      ),
    );
  }
}
