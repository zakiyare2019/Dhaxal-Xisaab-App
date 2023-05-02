import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class deceasedTable extends StatefulWidget {
  @override
  _deceasedTableState createState() => _deceasedTableState();
}

class _deceasedTableState extends State<deceasedTable> {
  var _data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final response = await http.get(
        Uri.parse('http://192.168.32.2/inheritance_api/deceasedTable.php'));
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
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Gender',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Date of Death',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Hantidiisa',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Deen',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Dardaaran',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: _data
                .map((row) => DataRow(cells: [
                      DataCell(
                        Text(row['deceased_id']),
                        onTap: () {
                          print('You tapped column 1 of ${row['deceased_id']}');
                        },
                      ),
                      DataCell(
                        Text(row['name']),
                        onTap: () {
                          print('You tapped column 2 of ${row['name']}');
                        },
                      ),
                      DataCell(
                        Text(row['gender']),
                        onTap: () {
                          print('You tapped column 3 of ${row['gender']}');
                        },
                      ),
                      DataCell(
                        Text(row['date_of_death']),
                        onTap: () {
                          print(
                              'You tapped column 4 of ${row['date_of_death']}');
                        },
                      ),
                      DataCell(
                        Text(row['hanti']),
                        onTap: () {
                          print('You tapped column 5 of ${row['hanti']}');
                        },
                      ),
                      DataCell(
                        Text(row['deen']),
                        onTap: () {
                          print('You tapped column 6 of ${row['deen']}');
                        },
                      ),
                      DataCell(
                        Text(row['dardaaran']),
                        onTap: () {
                          print('You tapped column 7 of ${row['dardaaran']}');
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
