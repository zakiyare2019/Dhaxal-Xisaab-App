import 'package:flutter/material.dart';
import 'registration.dart' as heirs;
import 'deceasedRegistration.dart' as deceased;
import 'managedeceased.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'manageheirs.dart'as mgheirs;
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> _dataList = [];
  List<Map<String, dynamic>> _dataList2 = [];

  Future<void> fetchData() async {
  final response = await http.get(Uri.parse("http://172.24.16.1/inheritance_api/deceasedtable.php"));
  
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    setState(() {
      _dataList = jsonData.cast<Map<String, dynamic>>();
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ManageDeceasedScreen(data: _dataList),
    ));
  } else {
    print('Failed to load data');
  }
}
 Future<void> fetchData2() async {
  final response = await http.get(Uri.parse("http://172.24.16.1/inheritance_api/heirstable.php"));
  
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    setState(() {
      _dataList2 = jsonData.cast<Map<String, dynamic>>();
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => mgheirs.ManageDeceasedScreen(data: _dataList2),
    ));
  } else {
    print('Failed to load data');
  }
}

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DashboardOptionCard(
              icon: Icons.person_off,
              title: 'Manage Deceased',
              onTap: () {
                fetchData();
              },
            ),
            SizedBox(height: 20),
            DashboardOptionCard(
              icon: Icons.accessibility_new,
              title: 'Manage Heirs',
              onTap: () {
                 fetchData2();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  DashboardOptionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
