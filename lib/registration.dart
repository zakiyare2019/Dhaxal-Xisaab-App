import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectRelationship;
  String? selectDeceased;
  int? selectedId;
  
  List<Map<String, dynamic>> deceasedOptions = [];

  @override
  void initState() {
    super.initState();
    fetchDeceasedOptions();
  }

  Future<void> fetchDeceasedOptions() async {
    try {
      final response = await http.get(
          Uri.parse('http://172.24.16.1/inheritance_api/marxuumread.php'));
      if (response.statusCode == 200) {
        final dynamic decodedResponse = json.decode(response.body);

        if (decodedResponse is List && decodedResponse.length > 1) {
          List<Map<String, dynamic>> options = decodedResponse
              .where((item) =>
                  item is Map<String, dynamic> &&
                  item.containsKey("name") &&
                  item["name"].isNotEmpty &&
                  item.containsKey("id"))
              .map((item) => {
                    "name": item["name"].toString(),
                    "id": int.parse(item["id"].toString()),
                  })
              .toList();

          setState(() {
            deceasedOptions = options;
          });
        } else {
          print('Failed to load deceased options');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deceased options: $e');
    }
  }

  Future<void> insertHeirs2() async {
    if (_formKey.currentState!.validate()) {
      final _url =
          Uri.parse("http://172.24.16.1/inheritance_api/dhaxlayaalregistration.php");
      final mp = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "relationship": selectRelationship,
        "deceasedID": selectedId.toString(),
      };

      

      try {
        final response = await http.post(_url, body: mp);
        if (response.statusCode == 200) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("successfully Inserted"),
      ));
      Navigator.pop(context);
      
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to insert"),
      ));
      Navigator.pop(context);
      ;
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error  $e"),
      ));
      Navigator.pop(context);
      
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropdownField(
                    data: Icons.person_2_sharp,
                    hintText: "Select deceased",
                    value: selectDeceased,
                    onChanged: (value) {
                      setState(() {
                        selectDeceased = value;
                        selectedId = deceasedOptions
                            .firstWhere(
                                (option) => option['name'] == value)['id'];
                      });
                    },
                    items: deceasedOptions
                        .map((option) => option['name'].toString())
                        .toList(),
                  ),

                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                  ),
                  CustomTextField(
                    data: Icons.phone,
                    controller: phoneController,
                    hintText: "Phone",
                  ),
                  CustomDropdownField(
                    data: Icons.person_2_sharp,
                    hintText: "Select the Relationship",
                    value: selectRelationship,
                    onChanged: (value) {
                      setState(() {
                        selectRelationship = value;
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
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff94b723),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await insertHeirs2();
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final IconData data;
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final bool enabled;

  CustomTextField({
    required this.data,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(data),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please fill in this field";
          }
          return null;
        },
      ),
    );
  }
}

class CustomDropdownField extends StatefulWidget {
  final IconData data;
  final String hintText;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;

  CustomDropdownField({
    required this.data,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(widget.data),
          labelText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: widget.value,
            onChanged: widget.onChanged,
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

