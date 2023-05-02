import 'dart:convert';

import 'package:flutter/material.dart';

class Heir {
  final String name;
  final double share;

  Heir(this.name, this.share);

  Heir.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        share = double.parse(json['share'].toString());
}

class InheritanceScreen extends StatefulWidget {
  final String jsonData;

  const InheritanceScreen({Key? key, required this.jsonData}) : super(key: key);

  @override
  _InheritanceScreenState createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
  late List<Heir> heirs;

  @override
  void initState() {
    super.initState();
    var jsonData = json.decode(widget.jsonData);
    heirs = List<Heir>.from(jsonData['heirs'].map((x) => Heir.fromJson(x)));
  }

  // rest of the code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inheritance Information'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Heirs and their shares:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: heirs.length,
              itemBuilder: (context, index) {
                final heir = heirs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${heir.name}:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${heir.share} %',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
