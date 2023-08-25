import 'registration.dart' as heir;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManageDeceasedScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  ManageDeceasedScreen({required this.data});

  @override
  _ManageDeceasedScreenState createState() => _ManageDeceasedScreenState();
}

class _ManageDeceasedScreenState extends State<ManageDeceasedScreen> {
  List<Map<String, dynamic>> deceasedList = [];

  @override
  void initState() {
    super.initState();
    deceasedList = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Heirs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => heir.SignUpScreen(),
                  ));
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Relationship')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: deceasedList
                      .map(
                        (deceased) => DataRow(
                          cells: [
                            DataCell(Text(deceased['id'].toString())),
                            DataCell(Text(deceased['name'].toString())),
                            DataCell(Text(deceased['email'].toString())),
                            DataCell(Text(deceased['phone'].toString())),
                            DataCell(Text(deceased['relationship'].toString())),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () =>
                                        _editDeceased(context, deceased),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteDeceased(context, deceased),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editDeceased(BuildContext context, Map<String, dynamic> deceased) {
    TextEditingController nameController =
        TextEditingController(text: deceased['name']);
    TextEditingController emailController =
        TextEditingController(text: deceased['email'].toString());
    TextEditingController phoneController =
        TextEditingController(text: deceased['phone'].toString());
    String selectedrelationship = deceased['relationship'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Deceased'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email')),
              TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number')),
              DropdownButtonFormField<String>(
                value: selectedrelationship,
                onChanged: (value) {
                  setState(() {
                    selectedrelationship = value!;
                  });
                },
                items: [
                  'Father',
                  'Mother',
                  'Husband',
                  'Wife',
                  'Son',
                  'Daughter',
                  'Full Brother',
                  'paternal Brother',
                  'maternal Brother',
                  'Full Sister',
                  'paternal Sister',
                  'maternal Sister'
                ]
                    .map((relation) => DropdownMenuItem(
                        value: relation, child: Text(relation)))
                    .toList(),
                decoration: InputDecoration(labelText: 'Relationship'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _updateDeceasedOnServer(
                    {
                      'id': deceased['id'], // Make sure to include the correct ID here
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'relationship': selectedrelationship,
                    },
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteDeceased(BuildContext context, Map<String, dynamic> deceased) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content:
              Text('Are you sure you want to delete ID ${deceased['id']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform delete logic
                setState(() {
                  _deleteDeceasedOnServer(deceased['id']);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateDeceasedOnServer(
      Map<String, dynamic> updatedDeceased) async {
    final String url = 'http://172.24.16.1/inheritance_api/updateheirs.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': updatedDeceased['id'].toString(),
        'name': updatedDeceased['name'],
        'email': updatedDeceased['email'],
        'phone': updatedDeceased['phone'],
        'relationship': updatedDeceased['relationship'],
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("successfully updated"),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update"),
      ));
    }
  }

  Future<void> _deleteDeceasedOnServer(String id) async {
    final String url = 'http://172.24.16.1/inheritance_api/delete_heirs.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("successfully deleted"),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete "),
      ));
    }
  }
}
