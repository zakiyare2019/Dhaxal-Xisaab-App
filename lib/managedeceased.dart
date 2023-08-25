import 'package:flutter/material.dart';
import 'deceasedRegistration.dart';
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
    // Initializing the deceasedList with the provided data
    deceasedList = widget.data; // Assign the passed data to the deceasedList
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Deceased'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Implement your logic for adding a new deceased item
                  // For example: _addNewDeceased(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
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
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Loan')),
                    DataColumn(label: Text('Will')),
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: deceasedList
                      .map(
                        (deceased) => DataRow(
                          cells: [
                            DataCell(Text(deceased['id'].toString())),
                            DataCell(Text(deceased['name'].toString())),
                            DataCell(Text(deceased['total_asset'].toString())),
                            DataCell(Text(deceased['loan_amount'].toString())),
                            DataCell(Text(deceased['will_amount'].toString())),
                            DataCell(Text(deceased['gender'].toString())),
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
    TextEditingController totalController =
        TextEditingController(text: deceased['total_asset'].toString());
    TextEditingController loanController =
        TextEditingController(text: deceased['loan_amount'].toString());
    TextEditingController willController =
        TextEditingController(text: deceased['will_amount'].toString());
    String selectedGender = deceased['gender']; // Initialize selected gender

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
                  controller: totalController,
                  decoration: InputDecoration(labelText: 'Total Assets')),
              TextField(
                  controller: loanController,
                  decoration: InputDecoration(labelText: 'Loan Amount')),
              TextField(
                  controller: willController,
                  decoration: InputDecoration(labelText: 'Will Amount')),
              DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                items: ['Male', 'Female']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                decoration: InputDecoration(labelText: 'Gender'),
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
                    'id': deceased[
                        'id'], // Make sure to include the correct ID here
                    'name': nameController.text,
                    'total_asset': double.parse(totalController.text),
                    'loan_amount': double.parse(loanController.text),
                    'will_amount': double.tryParse(willController.text) ?? 0.0,
                    'gender': selectedGender,
                  },
                );});Navigator.pop(context);
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
    final String url = 'http://172.24.16.1/inheritance_api/update_deceased.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': updatedDeceased['id'].toString(),
        'name': updatedDeceased['name'],
        'total_asset': updatedDeceased['total_asset'].toString(),
        'loan_amount': updatedDeceased['loan_amount'].toString(),
        'will_amount': updatedDeceased['will_amount'].toString(),
        'gender': updatedDeceased['gender'],
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deceased updated successfully"),
      ));
      Navigator.pop(context);
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update deceased"),
      ));
    }
  }
  

Future<void> _deleteDeceasedOnServer(
      String id ) async {
    final String url = 'http://172.24.16.1/inheritance_api/delete_deceased.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id,
        
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deceased deleted successfully"),
      ));
      Navigator.pop(context);
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete deceased"),
      ));
    }
  }}

  