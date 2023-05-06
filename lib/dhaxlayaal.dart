import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'insertHeirs.dart';
// import 'main.dart';
import 'result.dart';
import 'masaxbaa.dart';
import 'result.dart';

class dhaxlayaal extends StatefulWidget {
  @override
  State<dhaxlayaal> createState() => _dhaxlayaalState();
}

class _dhaxlayaalState extends State<dhaxlayaal> {
  final _marxuumidcontroller = TextEditingController();
  final lacag = TextEditingController();
  final wiil = TextEditingController();
  final gabar = TextEditingController();
  final aabo = TextEditingController();
  final hooyo = TextEditingController();
  final abaayo = TextEditingController();
  final aboowe = TextEditingController();
  final marwo = TextEditingController();
  final xaasle = TextEditingController();
  final adeer = TextEditingController();

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
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 5, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(5),
                        // color: Color.fromARGB(255, 169, 115, 245),
                        child: TextFormField(
                          controller: _marxuumidcontroller,
                          decoration: InputDecoration(
                            labelText: 'Magaca Marxuum ',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(5),
                        // color: Color.fromARGB(255, 169, 115, 245),
                        child: TextFormField(
                          controller: lacag,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hanti ',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                          marxuumID: _marxuumidcontroller.text,
                          aabo: aabo.text,
                          hooyo: hooyo.text,
                          abaayo: abaayo.text,
                          aboowe: aboowe.text,
                          wiil: wiil.text,
                          gabar: gabar.text,
                          xaasle: xaasle.text,
                          marwo: marwo.text,
                          adeer: adeer.text);

                      var wiilal = double.parse(wiil.text);
                      var gabdho = double.parse(gabar.text);
                      var aaboo = double.parse(aabo.text);
                      var hooyoo = double.parse(hooyo.text);
                      var aboowee = double.parse(aboowe.text);
                      var abaayoo = double.parse(abaayo.text);
                      var adeere = double.parse(adeer.text);
                      var marwoo = double.parse(marwo.text);
                      var xaaslee = double.parse(xaasle.text);

                      var wiilalshare = 0.0;
                      var gabdhoshare = 0.0;
                      var aaboshare = 0.0;
                      var hooyoshare = 0.0;
                      var abooweshare = 0.0;
                      var abaayoshare = 0.0;
                      var adeershare = 0.0;
                      var marwoshare = 0.0;
                      var xaasleshare = 0.0;

                      if (wiilal >= 1 && gabdho == 0) {
                        wiilalshare = (1);
                      }

                      if ((wiilal == 0 || gabdho == 0)) {
                        if (xaaslee == 1) {
                          marwoshare = (1 / 4);
                        }
                        if (marwoo == 1) {
                          xaasleshare = (1 / 2);
                        }
                      }

                      if ((wiilal >= 1 || gabdho >= 1)) {
                        wiilalshare = (2);
                        gabdhoshare = (1);
                        if (xaaslee == 1) {
                          marwoshare = (1 / 8);
                        }
                        if (marwoo == 1) {
                          xaasleshare = (1 / 4);
                        }
                        if (aaboo == 1) {
                          aaboshare = (1 / 6);
                        }
                        if (hooyoo == 1) {
                          hooyoshare = (1 / 6);
                        }
                      }
                      if (wiilal == 0 && gabdho == 1) {
                        gabdhoshare = (1 / 2);
                      }
                      if (wiilal == 0 && gabdho == 0 && abaayoo == 1) {
                        abaayoshare = (1 / 2);
                      }
                      if (wiilal == 0 && gabdho > 1) {
                        gabdhoshare = (2 / 3);
                      }
                      if (wiilal == 0 && gabdho == 0 && abaayoo > 1) {
                        abaayoshare = (2 / 3);
                      }
                      if ((wiilal == 0 || gabdho == 0) &&
                          (abaayoo > 1 || wiilal > 1)) {
                        hooyoshare = (1 / 3);
                      }
                      if ((wiilal >= 1 || gabdho >= 1) &&
                          (abaayoo > 1 || wiilal > 1)) {
                        hooyoshare = (1 / 6);
                      }
                      final inheritance = calculateIslamicInheritance(
                          double.parse(lacag.text.toString()),
                          wiilalshare,
                          gabdhoshare,
                          marwoshare,
                          abooweshare,
                          abaayoshare,
                          aaboshare,
                          hooyoshare,
                          adeershare,
                          xaasleshare);

                      final json = jsonEncode(
                        inheritance
                            .map(
                              (h) => {'name': h.name, 'share': h.share},
                            )
                            .toList(),
                      );
                      String jjj = '{"heirs": ' + json + '}';

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: InheritanceScreen(
                              jsonData: jjj,
                            ),
                          ),
                        ),
                      );
                      final response = await data.insertHeirs2();
                      wiil.clear();
                      _marxuumidcontroller.clear();
                      lacag.clear();
                      gabar.clear();
                      aabo.clear();
                      hooyo.clear();
                      xaasle.clear();
                      marwo.clear();
                      adeer.clear();
                      aboowe.clear();
                      abaayo.clear();
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
