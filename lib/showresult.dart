// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'result.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PHP API Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Map<String, dynamic>> data = [];

//   double husbandShare = 0.0;
//   double wifeShare = 0.0;
//   double daughterShare = 0.0;
//   double fatherShare = 0.0;
//   double motherShare = 0.0;
//   double sonShare = 0.0;
//   double fullBrotherShare = 0.0;
//   double paternalBrotherShare = 0.0;
//   double maternalBrotherShare = 0.0;
//   double fullSisterShare = 0.0;
//   double paternalSisterShare = 0.0;
//   double maternalSisterShare = 0.0;
//   double remain = 0.0;

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://192.168.7.15/inheritance_api/readingDhaxlayaal.php'));

//       if (response.statusCode == 200) {
//         setState(() {
//           data = List<Map<String, dynamic>>.from(json.decode(response.body));
//           calculate();
//         });
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     calculate();
//     dir(context);
//   }

//   void calculate() {
//     var lacag = 100.0;
//     var fatherExists = 0;
//     var motherExists = 0;
//     var husband = 0;
//     var wife = 0;
//     var sons = 0;
//     var daughters = 0;
//     var fullBrothers = 0;
//     var paternalBrothers = 0;
//     var maternalBrothers = 0;
//     var sister = 0;
//     var pateralSister = 0;
//     var MaternalSister = 0;
//     print("==================== $data");
//     for (int i = 0; i < data.length; i++) {
//       final items = data[i];
//       if (items['relationship'] == "Father") {
//         fatherExists =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Mother") {
//         motherExists =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Husban") {
//         husband = int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "wife") {
//         wife = int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Son") {
//         sons = int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Daughter") {
//         daughters =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Full Brother") {
//         fullBrothers =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "paternal Brother") {
//         paternalBrothers =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "maternal Brother") {
//         maternalBrothers =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "Full Sister") {
//         sister = int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "paternal Sister") {
//         pateralSister =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }
//       if (items['relationship'] == "maternal Sister") {
//         MaternalSister =
//             int.tryParse(items['count']) ?? 0; // Convert count to integer
//       }

//       // Calculate husband's share
//       if (sons == 0 && daughters == 0) {
//         husbandShare = 0.5 * husband * lacag;
//       } else {
//         husbandShare = 0.25 * husband * lacag;
//       }
//       // Calculate wife's share
//       if (sons == 0 && daughters == 0) {
//         wifeShare = 0.25 * wife * lacag;
//       } else {
//         wifeShare = 0.125 * wife * lacag;
//       }

// // Calculate father's share
//       if (sons == 0 && daughters == 0 && (husband == 0 || wife == 0)) {
//         if (motherExists == 1) {
//           fatherShare = (lacag - (lacag * 1 / 3)) * fatherExists;
//         } else {
//           fatherShare = lacag * fatherExists;
//         }
//       } else {
//         fatherShare = lacag * (1 / 6) * fatherExists;
//       }

//       // Calculate mother's share

//       if ((sons > 0 || daughters > 0) || fullBrothers > 1) {
//         motherShare = motherExists * lacag * (1 / 6);
//       } else {
//         motherShare = motherExists * lacag * (1 / 3);
//       }
// // Calculate maternal  share
//       if ((sons == 0 && daughters == 0) && fatherExists == 0) {
//         if (maternalBrothers == 1 && MaternalSister == 0) {
//           maternalBrotherShare = ((1 / 6) * lacag);
//         } else if (maternalBrothers == 0 && MaternalSister == 1) {
//           maternalSisterShare = ((1 / 6) * lacag);
//         } else {
//           var maternalchilds = MaternalSister + maternalBrothers;
//           double qeeb = ((1 / 3) * lacag) / maternalchilds;
//           maternalSisterShare = qeeb * MaternalSister;
//           maternalBrotherShare = qeeb * maternalBrothers;
//         }
//       }

//       var total = fatherShare +
//           motherShare +
//           husbandShare +
//           wifeShare +
//           maternalBrotherShare +
//           maternalSisterShare;
//       remain = lacag - total;
//       int sondaughtershares = (2 * sons) + daughters;
// // Calculate son's share
//       if (sons > 0 && daughters == 0) {
//         sonShare = remain / sons;
//       } else if (sons > 1 && daughters == 0) {
//         sonShare = remain / ((2 * sons) + daughters);
//       } else if (sons >= 1 && daughters >= 1) {
//         sonShare = ((remain / sondaughtershares * 2)) * sons;
//       }

//       // Calculate daughter's share
//       if (daughters == 1 && sons == 0) {
//         daughterShare = 0.5 * lacag;
//       } else if (daughters > 1 && sons == 0) {
//         daughterShare = (2 / 3) * lacag;
//       } else if (daughters >= 1 && sons >= 1) {
//         daughterShare = (remain / sondaughtershares) * daughters;
//       }
//       var rmain2 = remain - (daughterShare + sonShare);
//       // Calculate full sister share
//       if (fatherExists == 0 && sons == 0 && daughters == 0) {
//         if (fullBrothers == 0 && sister == 1) {
//           fullSisterShare = 0.5 * lacag;
//           rmain2 -= fullSisterShare;
//         } else if (fullBrothers == 0 && sister > 1) {
//           fullSisterShare = ((2 / 3) * lacag);
//           rmain2 -= fullSisterShare;
//         } else if (fullBrothers >= 1 && sister >= 1) {
//           fullSisterShare = ((rmain2 / ((2 * fullBrothers) + sister))) * sister;
//         }
//       }

//       // Calculate full brother share
//       if (fatherExists == 0 && sons == 0) {
//         if (fullBrothers == 1 && sister == 0) {
//           fullBrotherShare = rmain2;
//         } else if (fullBrothers > 1 && sister == 0) {
//           fullBrotherShare = rmain2;
//         } else if (fullBrothers >= 1 && sister >= 1) {
//           fullBrotherShare =
//               ((rmain2 / ((2 * fullBrothers) + sister))) * fullBrothers;
//         }
//       }
//       int paternalMaternalBrothers = pateralSister + paternalBrothers;

// // Calculate paternal sister share
//       if (fatherExists == 0 &&
//           sons == 0 &&
//           daughters == 0 &&
//           sister == 0 &&
//           fullBrothers == 0) {
//         if (paternalBrothers == 0 &&
//             pateralSister == 1 &&
//             fullBrothers == 0 &&
//             sister == 0) {
//           paternalSisterShare = 0.5 * lacag;
//           remain -= paternalSisterShare;
//         } else if (paternalBrothers == 0 &&
//             pateralSister > 1 &&
//             sister == 0 &&
//             fullBrothers == 0) {
//           paternalSisterShare = ((2 / 3) * lacag);
//           remain -= paternalSisterShare;
//         } else if (paternalBrothers >= 1 &&
//             pateralSister >= 1 &&
//             sister == 0 &&
//             fullBrothers == 0) {
//           paternalSisterShare =
//               ((remain / ((2 * paternalBrothers) + pateralSister))) *
//                   pateralSister;
//         }
//       }

//       // Calculate paternal brother share
//       if (fatherExists == 0 && sons == 0) {
//         if (paternalBrothers == 1 && pateralSister == 0) {
//           paternalBrotherShare = remain;
//         } else if (paternalBrothers > 1 && pateralSister == 0) {
//           paternalBrotherShare = remain / paternalBrothers;
//         } else if (paternalBrothers >= 1 && pateralSister >= 1) {
//           paternalBrotherShare =
//               ((remain / ((2 * paternalBrothers) + pateralSister))) *
//                   paternalBrothers;
//         }
//       }
//       ;
//     }
//   }

//   void dir(BuildContext context) {
//     setState(() {
//       Map<String, dynamic> inheritanceValues = {
//         'heirs': [
//           {'name': 'Husband Share', 'share': husbandShare},
//           {'name': 'Wife Share', 'share': wifeShare},
//           {'name': 'Son Share', 'share': sonShare},
//           {'name': 'Daughter Share', 'share': daughterShare},
//           {'name': 'Father Share', 'share': fatherShare},
//           {'name': 'Mother Share', 'share': motherShare},
//           {'name': 'Full Brother Share', 'share': fullBrotherShare},
//           {'name': 'Paternal Brother Share', 'share': paternalBrotherShare},
//           {'name': 'Maternal Brother Share', 'share': maternalBrotherShare},
//           {'name': 'Full Sister Share', 'share': fullSisterShare},
//           {'name': 'Paternal Sister Share', 'share': paternalSisterShare},
//           {'name': 'Maternal Sister Share', 'share': maternalSisterShare},
//         ],
//       };
//       inheritanceValues['heirs'].removeWhere((heir) => heir['share'] == 0);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => InheritanceScreen(
//             jsonData: jsonEncode(inheritanceValues),
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
