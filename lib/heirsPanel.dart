import 'package:dhaxalxisaab/dhaxlayaal.dart';
import 'package:flutter/material.dart';
import 'heirsTable.dart';
import 'insertHeirs.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text('Dhaxlayaal'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                text: 'New Record',
              ),
              Tab(
                text: 'show Records',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [dhaxlayaal(), myApp()],
        ),
      ),
    );
  }
}
