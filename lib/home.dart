import 'package:flutter/material.dart';
import 'dhaxlayaal.dart';
import 'marxuum.dart';
import 'main.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 350),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                              // backgroundColor: AppColors.mainColor,
                              appBar: AppBar(
                                title: Text("Marxxumka"),
                                centerTitle: true,
                              ),
                              body: Container(
                                  // margin: EdgeInsets.only(top: 50),
                                  child: design())),
                        ),
                      ),
                    );
                  },
                  child: Text("Diiwaan gali Marxuumka"))),
          SizedBox(
            width: 100,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 20, left: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.red)))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                            // backgroundColor: AppColors.mainColor,
                            body: Container(
                                // margin: EdgeInsets.only(top: 50),
                                child: dhaxlayaal())),
                      ),
                    ),
                  );
                },
                child: Text("dhaxlayaal"),
              )),
          Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                              // backgroundColor: AppColors.mainColor,
                              body: Container(
                                  // margin: EdgeInsets.only(top: 50),
                                  child: home_page())),
                        ),
                      ),
                    );
                  },
                  child: Text("Qeebin"))),
          SizedBox(
            width: 100,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 20, left: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.red)))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(body: Container(child: home_page())),
                      ),
                    ),
                  );
                },
                child: Text("Daabaco"),
              ))
        ],
      ),
    );
  }
}
