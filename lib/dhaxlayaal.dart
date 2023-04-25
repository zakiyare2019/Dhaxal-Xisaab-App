import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'insertHeirs.dart';
// import 'main.dart';
import 'mysql.dart';
import 'home.dart';

class dhaxlayaal extends StatefulWidget {
  const dhaxlayaal({super.key});

  @override
  State<dhaxlayaal> createState() => _dhaxlayaalState();
}

class _dhaxlayaalState extends State<dhaxlayaal> {
  final wiil = TextEditingController();
  final gabar = TextEditingController();
  final aabo = TextEditingController();
  final hooyo = TextEditingController();
  final abaayo = TextEditingController();
  final aboowe = TextEditingController();
  final marwo = TextEditingController();
  final xaasle = TextEditingController();
  final adeer = TextEditingController();
  final wiilkaWalaal = TextEditingController();
  String? marxuumID;
  List lst = List.empty();

  String? id;
  Future getData() async {
    var url = 'http://192.168.32.2/inheritance_api/dhaxlayaal.php';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var datta = json.decode(res.body);
      setState(() {
        lst = datta;
        lst.removeAt(0);
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
    // void insertHeirs() {
    //   String _wiil = wiil.text;
    //   String _gabar = gabar.text;
    //   String _aabo = aabo.text;
    //   String _hooyo = hooyo.text;
    //   String _aboowe = aboowe.text;
    //   String _abaayo = abaayo.text;
    //   String _wiilkaWiilkiisa = wiilkaWalaal.text;
    //   String _adeer = adeer.text;
    //   String _xaasle = xaasle.text;
    //   String _marwo = marwo.text;
    //   final headers = {'Content-Type': 'application/json'};

    //   http.post(
    //       Uri.parse("http://192.168.32.2/inheritance_api/newdhaxlayaal.php"),
    //       // headers: headers,
    //       body: {
    //         "deceased_id": marxuumID,
    //         "wiilal": _wiil,
    //         "gabdho": _gabar,
    //         "aabo": _aabo,
    //         "hooyo": _hooyo,
    //         "aboowe": _aboowe,
    //         "abaayo": _abaayo,
    //         "wiilka_wiilkiisa": _wiilkaWiilkiisa,
    //         "adeer": adeer,
    //         "marwo": _marwo,
    //         "xaasle": _xaasle,
    //     }).then((response) {
    //   var data = jsonDecode(response.body);
    // });
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dhaxlayaal"),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 5, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    // margin: EdgeInsets.all(8),
                    color: Color.fromARGB(255, 169, 115, 245),
                    child: DropdownButton(
                      hint: Text('Dooro Mid'),
                      items: lst
                          .map((option) => DropdownMenuItem<String>(
                              child: Text(option.toString()),
                              value: option.toString()))
                          .toList(),
                      onChanged: (String? value) {
                        setState(
                          () {
                            id = value;
                            List i = id.toString().split(',').toList();
                            marxuumID = i[0].substring(4);
                            print(marxuumID);
                          },
                        );
                      },
                      value: id,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text(
                        'Wiil ama Wiilal:               ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: wiil,
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
                        'Gabar ama Gabdho:       ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: gabar,
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
                        'Aabo:                                ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: aabo,
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
                        'Hooyo:                              ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: hooyo,
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
                        'walaal wiila                      ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: aboowe,
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
                        'walaal  gabar                   ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: SizedBox(
                          width: 100.0,
                          height: 40,
                          child: TextField(
                            controller: abaayo,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
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
                        'Walaalka Wiilkiisa:          ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: wiilkaWalaal,
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
                        'Adeer:                               ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: adeer,
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
                        'marwo:                             ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: marwo,
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
                        'xaasle:                              ',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 40,
                        child: TextField(
                          controller: xaasle,
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
                      final data = HeirsInserter(
                          marxuumID: marxuumID.toString(),
                          aabo: aabo.text,
                          hooyo: hooyo.text,
                          abaayo: abaayo.text,
                          aboowe: aboowe.text,
                          wiilkaWalaal: wiilkaWalaal.text,
                          wiil: wiil.text,
                          gabar: gabar.text,
                          xaasle: xaasle.text,
                          marwo: marwo.text,
                          adeer: adeer.text);
                     
                      final response = await data.insertHeirs2();
                      // print('http.Response = '+response);
 
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => MaterialApp(
                      //       debugShowCheckedModeBanner: false,
                      //       home: Scaffold(body: Container(child: home_page())),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Keedi',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
