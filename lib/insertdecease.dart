import 'dart:convert';

import 'package:http/http.dart' as http;

class deceaseInserter {
  // final String deceaseID;
  final String name;
  final String gender;
  final String dateofdeath;
  final String hanti;
  final String deen;
  final String dardaaran;

  deceaseInserter(
      {
      // required this.deceaseID,
      required this.name,
      required this.gender,
      required this.dateofdeath,
      required this.hanti,
      required this.deen,
      required this.dardaaran});

  Future<void> insertHeirs2() async {
    final _url =
        Uri.parse("http://192.168.32.2/inheritance_api/newmarxuum.php");
    final mp = {
      "name": name,
      "gender": gender,
      "date_of_death": dateofdeath,
      "hanti": hanti,
      "deen": deen,
      "dardaaran": dardaaran
    };
    // print(mp);
    final _result = await http.post(_url, body: mp).then((response) {
      // print("------------------ ==" + response.body);
      //
      var data = jsonDecode(response.body);
      return data;
      // print(data);
    }).catchError((e) {
      print(e.toString());
    });
  }
}
