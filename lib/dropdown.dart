// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:mysql1/mysql1.dart';

// Future<void> main() async {
//   // runApp(app)
// }

// class MyWidget  extends StatelessWidget {
//   final conn = await MySqlConnection.connect(
//     ConnectionSettings(
//       host: 'localhost',
//       port: 3306,
//       user: 'your_username',
//       password: 'your_password',
//       db: 'your_database',
//     ),
//   );

//   final results = await conn.query('SELECT * FROM your_table');

//   final items = results.map((row) => row['name'] as String).toList();

//   await conn.close();

//   String dropdownValue = items[0];

//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
        
//   DropdownButton<String>(
//     value: dropdownValue,
//     onChanged: (String? newValue) {
//       setState(() {
//         dropdownValue = newValue!;
//       });
//     },
//     items: items
//         .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         })
//         .toList(),
//   );
//       ]),
//     );
//   }
// }
