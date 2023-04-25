import 'dart:convert';

import 'package:http/http.dart' as http;

class HeirsInserter {
  final String username;
  final String password;

  HeirsInserter({
    required this.username,
    required this.password,
  });

  Future<void> insertHeirs2() async {
    final _url = Uri.parse("http://192.168.32.2/inheritance_api/users.php");

    final _result = await http.post(_url, body: {
      "username": username,
      "password": password,
    }).then((response) {
      // print(response);
      var data = jsonDecode(response.body);
      // print("Successfully Inserted");
    });
  }
}
