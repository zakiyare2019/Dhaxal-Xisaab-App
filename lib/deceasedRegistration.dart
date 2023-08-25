import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController loanController = TextEditingController();
  TextEditingController assetController = TextEditingController();

  TextEditingController willController = TextEditingController();
  String? selectedGender;
   var data = [];
 Future<void> insertHeirs2() async {
  if (_formKey.currentState!.validate()) {
    final _url = Uri.parse("http://172.24.16.1/inheritance_api/marxuumregistration.php");
    final mp = {
      "name": nameController.text,
      "totalAsset": assetController.text,
      "loan": loanController.text,
      "will": willController.text,
      "gender": selectedGender,
    };


    try {
      final response = await http.post(_url, body: mp);
      Navigator.pop(context); // Close the "Processing" dialog

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _showMessageDialog("Success", "Data inserted successfully: $data");
      } else {
        print("Server responded with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to insert data");
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context); // Close the "Processing" dialog
      _showMessageDialog("Success", "Successfully insert data.");
    }
  }
}



void _showMessageDialog(String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.text, // Add keyboard type
                ),
                CustomTextField(
                  data: Icons.money,
                  controller: assetController,
                  hintText: "Total Asset",
                  keyboardType: TextInputType.number, // Add keyboard type
                ),
                CustomTextField(
                  data: Icons.email,
                  controller: loanController,
                  hintText: "Loan Amount",
                  keyboardType: TextInputType.number, // Add keyboard type
                ),
                CustomTextField(
                  data: Icons.phone,
                  controller: willController,
                  hintText: "Will Amount",
                  keyboardType: TextInputType.number, // Add keyboard type
                ),
                CustomDropdownField(
                  data: Icons.person_2_sharp,
                  hintText: "Select the Relatioship",
                  value: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  items: ['Male','Female'],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff94b723),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed:() async { // Call insertHeirs2 within an anonymous async function
      await insertHeirs2();
    },
              child: const Text(
                "Sign up",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
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
  final TextInputType? keyboardType; // Add keyboard type property

  CustomTextField({
    required this.data,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.enabled = true,
    this.keyboardType, // Add keyboard type parameter to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        enabled: enabled,
        keyboardType: keyboardType, // Set the keyboard type for the TextFormField
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

class CustomDropdownField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(data),
          labelText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map((String item) {
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
