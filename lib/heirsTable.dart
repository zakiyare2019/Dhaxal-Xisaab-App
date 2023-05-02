import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  var _data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final response = await http
        .get(Uri.parse('http://192.168.32.2/inheritance_api/heirsTable.php'));
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
        _data.removeAt(0);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        'Marxuum Table',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      )),
      ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text('ID',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Deceased',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('wiilal',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('gabdho',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('aabo',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('hooyo',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('aboowe',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('abaayo',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('wiilka_wiilkiisa',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('adeer',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('marwo',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('xaasle',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: _data
                .map((row) => DataRow(cells: [
                      DataCell(
                        Text(row['h_id']),
                        onTap: () {
                          print('You tapped column 1 of ${row['h_id']}');
                        },
                      ),
                      DataCell(
                        Text(row['deceased_id']),
                        onTap: () {
                          print('You tapped column 2 of ${row['deceased_id']}');
                        },
                      ),
                      DataCell(
                        Text(row['wiilal']),
                        onTap: () {
                          print('You tapped column 3 of ${row['wiilal']}');
                        },
                      ),
                      DataCell(
                        Text(row['gabdho']),
                        onTap: () {
                          print('You tapped column 4 of ${row['gabdho']}');
                        },
                      ),
                      
                      DataCell(
                        Text(row['aabo']),
                        onTap: () {
                          print('You tapped column 6 of ${row['aabo']}');
                        },
                      ),
                      DataCell(
                        Text(row['hooyo']),
                        onTap: () {
                          print('You tapped column 7 of ${row['hooyo']}');
                        },
                      ),
                      DataCell(
                        Text(row['aboowe']),
                        onTap: () {
                          print('You tapped column 1 of ${row['aboowe']}');
                        },
                      ),
                      DataCell(
                        Text(row['abaayo']),
                        onTap: () {
                          print('You tapped column 2 of ${row['abaayo']}');
                        },
                      ),
                      DataCell(
                        Text(row['wiilka_wiilkiisa']),
                        onTap: () {
                          print(
                              'You tapped column 3 of ${row['wiilka_wiilkiisa']}');
                        },
                      ),
                      DataCell(
                        Text(row['adeer']),
                        onTap: () {
                          print('You tapped column 4 of ${row['adeer']}');
                        },
                      ),
                      DataCell(
                        Text(row['marwo']),
                        onTap: () {
                          print('You tapped column 5 of ${row['marwo']}');
                        },
                      ),
                      DataCell(
                        Text(row['xaasle']),
                        onTap: () {
                          print('You tapped column 5 of ${row['xaasle']}');
                        },
                      ),
                    ]))
                .toList(),
          ),
        ),
      ),
    ]);
  }
}
