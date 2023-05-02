import 'package:dhaxalxisaab/dhaxlayaal.dart';
import 'package:flutter/material.dart';
import 'marxuum.dart';
import 'deceaseTable.dart';

class marxuumClass extends StatefulWidget {
  @override
  _marxuumClassState createState() => _marxuumClassState();
}

class _marxuumClassState extends State<marxuumClass>
    with SingleTickerProviderStateMixin {
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
          title: Text('Maxmuum'),
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
          children: [design(), deceasedTable()],
        ),
      ),
    );
  }
}
