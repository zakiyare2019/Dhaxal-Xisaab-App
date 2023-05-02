import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'insertdecease.dart';

class design extends StatefulWidget {
  @override
  State<design> createState() => _designState();
}

class _designState extends State<design> {
  @override

  // selectone? _character = "Male";
  String? _gender = '';
  final List<String> _character = ['Lab', 'Dhadig'];
  DateTime? _selectedDate;
  String? _name = "";
  num lacagta = 0;
  String? deen;
  final magacavariable = TextEditingController();
  final hantiVariable = TextEditingController();
  final deemoVariable = TextEditingController();
  final dardaaranVariable = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var selecteddate = null;
  List lst = List.empty();

  Future getData() async {
    var url = 'http://192.168.32.2/inheritance_api/marxuum.php';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var datta = json.decode(res.body);
      setState(() {
        lst = datta;
        lst.removeAt(0);
        print(lst);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var d = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 8, right: 8, top: 25),
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Magaca Marxuumka: ',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: magacavariable,
                  decoration: InputDecoration(
                    labelText: 'Magaca Marxuumka',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                    print(_name);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Jinsiyada Marxuumka",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            Row(
              children: [
                Radio(
                  value: _character[0],
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value.toString();
                      print(_gender);
                    });
                  },
                ),
                Text(
                  "Lab",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                Radio(
                  value: _character[1],
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value.toString();
                      print(_gender);
                    });
                  },
                ),
                Text(
                  "Dhadig",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Waqtiga uu Dhintay : ',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(width: 16.0),
                TextButton(
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        selecteddate = _selectedDate;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == null
                        ? DateTime.now().toString().substring(0, 10)
                        : '${_selectedDate.toString().substring(0, 10)}',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Text(
                      'Hantida Marxuumka:          ',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 40,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: hantiVariable,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Text(
                      'Deemaha lagu lee yahay:   ',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 40,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: deemoVariable,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Text(
                      'Lacagta La Dardaarmay:    ',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 40,
                      child: TextFormField(
                        controller: dardaaranVariable,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 43,
              child: ElevatedButton(
                  onPressed: () async {
                    final data = deceaseInserter(
                        name: magacavariable.text,
                        gender: _gender.toString(),
                        dateofdeath: selecteddate.toString(),
                        hanti: hantiVariable.text,
                        deen: deemoVariable.text,
                        dardaaran: dardaaranVariable.text);
                    final response = await data.insertHeirs2();
                    // if (_formKey.currentState!.validate())
                    //   {
                    //     // If the form is valid, display a snackbar. In the real world,
                    //     // you'd often call a server or save the information in a database.
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Processing Data')),
                    //     ),
                    // }
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => MaterialApp(
                    //           debugShowCheckedModeBanner: false,
                    //           home: Scaffold(
                    //               body: Container(child: home_page())),
                    //         )))
                  },
                  child: Text(
                    "Keedi",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
