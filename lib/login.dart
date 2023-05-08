import 'dart:convert';
import 'dart:io';
import 'package:dhaxalxisaab/dhaxlayaal.dart';
import 'package:dhaxalxisaab/register.dart';
import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class MyLogin extends StatefulWidget {

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  late var jawaab = [];
  Future<void> makelogin() async {
    final _url = Uri.parse("http://192.168.32.2/inheritance_api/users.php");

    final _result = await http.post(_url, body: {
      "username": username.text,
      "password": password.text,
    }).catchError((e) {
      print('Cach Error: ' + e.toString());
    });
    // debugPrint(_result.statusCode.toString());
    var result = jsonDecode(_result.body);
    jawaab = result;
    jawaab.removeAt(0);

    // print('==================' + lst.last.toString());
  }

  List lst = List.empty();

  Future getData() async {
    var url = 'http://192.168.32.2/inheritance_api/users.php';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var datta = json.decode(res.body);
      setState(() {
        lst = datta;
        lst.removeAt(0);
        print(lst);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/login.png'), fit: BoxFit.cover),
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome',
                style: TextStyle(color: Colors.blue, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 240,
                  // top: MediaQuery.of(context).size.height * 0.5
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(children: [
                              TextFormField(
                                controller: username,
                                style: TextStyle(color: Colors.blue),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "User Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Please enter an email address';
                                //   } else if (!value.contains('@')) {
                                //     return 'Please enter a valid email address';
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: password,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.blue,
                                    onPressed: () async {
                                      makelogin();

                                      if (jawaab.isEmpty) {
                                        // print("waa faaruq" + jawaab.toString());"
                                        final snack = SnackBar(
                                            content: Text(
                                                'User Name or Password are in correct'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack);
                                      } else {
                                        
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => MaterialApp(
                                              debugShowCheckedModeBanner: false,
                                              home: Scaffold(
                                                  // backgroundColor: AppColors.mainColor,
                                                  body: Container(
                                                      // margin: EdgeInsets.only(top: 50),
                                                      child: dhaxlayaal())),
                                            ),
                                          ),
                                        );
                                      }
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => MaterialApp(
                                      //       debugShowCheckedModeBanner: false,
                                      //       home: Scaffold(
                                      //           // backgroundColor: AppColors.mainColor,
                                      //           body: Container(
                                      //               // margin: EdgeInsets.only(top: 50),
                                      //               child: home_page())),
                                      //     ),
                                      //   ),
                                      // );
                                      // final data = HeirsInserter(
                                      //     username: username.text,
                                      //     password: password.text);
                                      // final response =
                                      //     await data.insertHeirs2();
                                      // var d = getData();
                                      //                   Navigator.of(context).push(
                                      // MaterialPageRoute(
                                      //   builder: (context) => MaterialApp(
                                      //     debugShowCheckedModeBanner: false,
                                      //     home: Scaffold(body: Container(child: home_page()
                                      // )
                                      // )
                                      //   ),
                                      // ),
                                      // );   // if (_formKey.currentState!.validate()) {
                                      //   print('waa faaruq page ka');
                                      // }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      body: MyRegister(),
                                    ),
                                  ));
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
