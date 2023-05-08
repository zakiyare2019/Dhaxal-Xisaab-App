import 'dart:convert';

import 'package:http/http.dart' as http;

class HeirsInserter {
  final String marxuumID;
  final String wiil;
  final String gabar;
  final String aabo;
  final String hooyo;
  final String aboowe;
  final String abaayo;

  final String adeer;
  final String xaasle;
  final String marwo;

  HeirsInserter({
    required this.marxuumID,
    required this.wiil,
    required this.gabar,
    required this.aabo,
    required this.hooyo,
    required this.aboowe,
    required this.abaayo,
    required this.adeer,
    required this.xaasle,
    required this.marwo,
  });
  
  Future<void> insertHeirs2() async {
    final _url =
        Uri.parse("http://192.168.32.2/inheritance_api/newdhaxlayaal.php");
    final mp = {
      "deceased_id": marxuumID,
      "wiilal": wiil,
      "gabdho": gabar,
      "aabo": aabo,
      "hooyo": hooyo,
      "aboowe": aboowe,
      "abaayo": abaayo,
      "adeer": adeer,
      "marwo": marwo,
      "xaasle": xaasle
    };
    
    // print(mp);
    final _result = await http.post(_url, body: mp).then((response) {
      // print("------------------ ==" + response.body);
      //
      var data = jsonDecode(response.body);
      // return data;
      // print(data);
    }).catchError((e) {
      print(e.toString());
    });
  }
}
