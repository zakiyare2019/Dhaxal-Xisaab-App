import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result.dart' as result;

class Identify extends StatefulWidget {
  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  List<Map<String, dynamic>> data = [];

  double husbandShare = 0.0;
  double wifeShare = 0.0;
  double daughterShare = 0.0;
  double fatherShare = 0.0;
  double motherShare = 0.0;
  double sonShare = 0.0;
  double fullBrotherShare = 0.0;
  double paternalBrotherShare = 0.0;
  double maternalBrotherShare = 0.0;
  double fullSisterShare = 0.0;
  double paternalSisterShare = 0.0;
  double maternalSisterShare = 0.0;
  double remain = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        
      ),
      body: Stack(
        children: [
          Container(),
          Container(
            padding: EdgeInsets.only(left: 90, top: 130),
            child: Text(
              'Identification',
              style: TextStyle(color: Colors.blue, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 240),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Phone number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Email or Phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                       
                                        _makeLogin(context);
                                      
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makeLogin(BuildContext context) async {
    final url = Uri.parse(
        "http://172.24.16.1/inheritance_api/readingDhaxlayaal.php");
    try {
      final response = await http.post(
        url,
        body: {"username": username.text},
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final status = responseData['status'];
        if (status == "success") {
          data = (responseData['data'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          _calculateShares(data);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(responseData['message'])));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to connect to API')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _calculateShares(List<Map<String, dynamic>> data) {
    var lacag = double.parse(data[0]['lacag']);

    var relationships = {
      'Father': 0,
      'Mother': 0,
      'Husband': 0,
      'Wife': 0,
      'Son': 0,
      'Daughter': 0,
      'Full Brother': 0,
      'Paternal Brother': 0,
      'Maternal Brother': 0,
      'Full Sister': 0,
      'Paternal Sister': 0,
      'Maternal Sister': 0,
    };

    for (var item in data) {
      var relationship = item['relationship'] as String;
      var count = int.tryParse(item['count'].toString()) ?? 0;
      if (relationships.containsKey(relationship)) {
        relationships[relationship] = count;
      }
    }

    var husband = relationships['Husband']!;
    var wife = relationships['Wife']!;
    var sons = relationships['Son']!;
    var daughters = relationships['Daughter']!;
    var fatherExists = relationships['Father']!;
    var motherExists = relationships['Mother']!;
    var fullBrothers = relationships['Full Brother']!;
    var paternalBrothers = relationships['Paternal Brother']!;
    var maternalBrothers = relationships['Maternal Brother']!;
    var sister = relationships['Full Sister']!;
    var pateralSister = relationships['Paternal Sister']!;
    var MaternalSister = relationships['Maternal Sister']!;

     husbandShare = (sons == 0 && daughters == 0)
        ? 0.5 * husband * lacag
        : 0.25 * husband * lacag;
     wifeShare = (sons == 0 && daughters == 0)
        ? 0.25 * wife * lacag
        : 0.125 * wife * lacag;

    fatherShare = _calculateFatherShare(
        fatherExists, motherExists, sons, daughters, husband, wife, lacag);
    motherShare = _calculateMotherShare(
        sons, daughters, fullBrothers, motherExists, lacag);
    maternalBrotherShare =
        _calculateMaternalBrotherShare(maternalBrothers, MaternalSister, lacag);
    maternalSisterShare =
        _calculateMaternalSisterShare(maternalBrothers, MaternalSister, lacag);

    var total = husbandShare +
        wifeShare +
        fatherShare +
        motherShare +
        maternalBrotherShare +
        maternalSisterShare;
    remain = lacag - total;
    sonShare = _calculateSonShare(sons, daughters, remain);
    daughterShare = _calculateDaughterShare(daughters, sons, lacag);
    var rmain2 = remain - (daughterShare + sonShare);
    fullBrotherShare = _calculateFullBrotherShare(fullBrothers, sister, rmain2);
    paternalBrotherShare =
        _calculatePaternalBrotherShare(paternalBrothers, pateralSister, rmain2);
    paternalSisterShare = _calculatePaternalSisterShare(
        paternalBrothers, pateralSister, sister, rmain2);
    _dir(context);
  }

  double _calculateFatherShare(int fatherExists, int motherExists, int sons,
      int daughters, int husband, int wife, double lacag) {
    if (sons == 0 && daughters == 0 && (husband == 0 || wife == 0)) {
      if (motherExists == 1) {
        return (lacag - (lacag * 1 / 3)) * fatherExists;
      } else {
        return lacag * fatherExists;
      }
    } else {
      return lacag * (1 / 6) * fatherExists;
    }
  }

  double _calculateMotherShare(int sons, int daughters, int fullBrothers,
      int motherExists, double lacag) {
    if ((sons > 0 || daughters > 0) || fullBrothers > 1) {
      return motherExists * lacag * (1 / 6);
    } else {
      return motherExists * lacag * (1 / 3);
    }
  }

  double _calculateMaternalBrotherShare(
      int maternalBrothers, int MaternalSister, double lacag) {
    if ((maternalBrothers == 1 && MaternalSister == 0) ||
        (maternalBrothers == 0 && MaternalSister == 1)) {
      return (1 / 6) * lacag;
    } else if (maternalBrothers > 1 || MaternalSister > 1) {
      var maternalchilds = MaternalSister + maternalBrothers;
      var qeeb = ((1 / 3) * lacag) / maternalchilds;
      return qeeb * (maternalBrothers + MaternalSister);
    } else {
      return 0;
    }
  }

  double _calculateMaternalSisterShare(
      int maternalBrothers, int MaternalSister, double lacag) {
    if ((maternalBrothers == 1 && MaternalSister == 0) ||
        (maternalBrothers == 0 && MaternalSister == 1)) {
      return (1 / 6) * lacag;
    } else if (maternalBrothers > 1 || MaternalSister > 1) {
      var maternalchilds = MaternalSister + maternalBrothers;
      var qeeb = ((1 / 3) * lacag) / maternalchilds;
      return qeeb * MaternalSister;
    } else {
      return 0;
    }
  }

  double _calculateSonShare(int sons, int daughters, double remain) {
    if (sons > 0) {
      return (daughters == 0)
          ? remain / sons
          : ((remain / (2 * sons + daughters)) * 2) * sons;
    }
    return 0;
  }

  double _calculateDaughterShare(int daughters, int sons, double lacag) {
    if (daughters == 1 && sons == 0) {
      return 0.5 * lacag;
    } else if (daughters > 1 && sons == 0) {
      return (2 / 3) * lacag;
    } else if (daughters >= 1 && sons >= 1) {
      return ((lacag / (2 * sons + daughters)) * daughters);
    }
    return 0;
  }

  double _calculateFullBrotherShare(
      int fullBrothers, int sister, double remain) {
    if (fullBrothers == 1 && sister == 0) {
      return remain;
    } else if (fullBrothers > 1 && sister == 0) {
      return remain / fullBrothers;
    } else if (fullBrothers >= 1 && sister >= 1) {
      return (remain / (2 * fullBrothers + sister)) * fullBrothers;
    }
    return 0;
  }

  double _calculatePaternalBrotherShare(
      int paternalBrothers, int pateralSister, double remain) {
    if (paternalBrothers == 1 && pateralSister == 0) {
      return remain;
    } else if (paternalBrothers > 1 && pateralSister == 0) {
      return remain / paternalBrothers;
    } else if (paternalBrothers >= 1 && pateralSister >= 1) {
      return (remain / (2 * paternalBrothers + pateralSister)) *
          paternalBrothers;
    }
    return 0;
  }

  double _calculatePaternalSisterShare(
      int paternalBrothers, int pateralSister, int sister, double remain) {
    if (paternalBrothers == 0 && pateralSister == 1 && sister == 0) {
      return 0.5 * remain;
    } else if (paternalBrothers == 0 && pateralSister > 1 && sister == 0) {
      return (2 / 3) * remain;
    } else if (paternalBrothers >= 1 && pateralSister >= 1 && sister == 0) {
      return (remain / (2 * paternalBrothers + pateralSister)) * pateralSister;
    }
    return 0;
  }

  void _dir(BuildContext context) {
    setState(() {
      Map<String, dynamic> inheritanceValues = {
        'heirs': [
          {'name': 'Husband Share', 'share': husbandShare},
          {'name': 'Wife Share', 'share': wifeShare},
          {'name': 'Son Share', 'share': sonShare},
          {'name': 'Daughter Share', 'share': daughterShare},
          {'name': 'Father Share', 'share': fatherShare},
          {'name': 'Mother Share', 'share': motherShare},
          {'name': 'Full Brother Share', 'share': fullBrotherShare},
          {'name': 'Paternal Brother Share', 'share': paternalBrotherShare},
          {'name': 'Maternal Brother Share', 'share': maternalBrotherShare},
          {'name': 'Full Sister Share', 'share': fullSisterShare},
          {'name': 'Paternal Sister Share', 'share': paternalSisterShare},
          {'name': 'Maternal Sister Share', 'share': maternalSisterShare},
        ],
      };
      inheritanceValues['heirs'].removeWhere((heir) => heir['share'] == 0);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => result.InheritanceScreen(
            jsonData: jsonEncode(inheritanceValues),
          ),
        ),
      );
    });
    
  }
  
}
