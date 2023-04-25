// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class HeirsInserter {
//   final String marxuumID;
//   final String wiil;
//   final String gabar;
//   final String aabo;
//   final String hooyo;
//   final String aboowe;
//   final String abaayo;
//   final String wiilkaWalaal;
//   final String adeer;
//   final String xaasle;
//   final String marwo;

//   HeirsInserter({
//     required this.marxuumID,
//     required this.wiil,
//     required this.gabar,
//     required this.aabo,
//     required this.hooyo,
//     required this.aboowe,
//     required this.abaayo,
//     required this.wiilkaWalaal,
//     required this.adeer,
//     required this.xaasle,
//     required this.marwo,
//   });

//   Future<void> insertHeirs2() async {
//     final _url =
//         Uri.parse("http://192.168.32.2/inheritance_api/newdhaxlayaal.php");

//     final _result = await http.post(_url, body: {
//       "deceased_id": marxuumID,
//       "wiilal": wiil,
//       "gabdho": gabar,
//       "aabo": aabo,
//       "hooyo": hooyo,
//       "aboowe": aboowe,
//       "abaayo": abaayo,
//       "wiilka_wiilkiisa": wiilkaWalaal,
//       "adeer": adeer,
//       "marwo": marwo,
//       "xaasle": xaasle,
//     }).then((response) {
//       print(response);
//       var data = jsonDecode(response.body);
//       print(data);
//     });
//   }
// }
