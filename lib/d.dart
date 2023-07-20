import 'package:dhaxalxisaab/dd.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'result.dart' as result;

enum Gender { male, female }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DhaxalXisaab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, errorColor: Colors.red),
      home: InheritanceCalculatorScreen(),
    );
  }
}

class InheritanceCalculatorScreen extends StatefulWidget {
  @override
  _InheritanceCalculatorScreenState createState() =>
      _InheritanceCalculatorScreenState();
}

int _fatherStatusValue = 1;
int _motherStatusValue = 1;
int _husbanStatusValue = 0;
int _wifeStatusValue = 0;

class _InheritanceCalculatorScreenState
    extends State<InheritanceCalculatorScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  Gender _selectedGender = Gender.male;
  TextEditingController _deceasedNameController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();
  TextEditingController _loanAmountController = TextEditingController();
  TextEditingController _willAmountController = TextEditingController();
  TextEditingController _numberOfChildrenController = TextEditingController();
  TextEditingController _numberOfSiblingsController = TextEditingController();
  TextEditingController _hasWillController = TextEditingController();
  TextEditingController _debtAmountController = TextEditingController();
  GlobalKey<FormState> _page1FormKey =
      GlobalKey<FormState>(); // Form key for Page1
  GlobalKey<FormState> _page2FormKey =
      GlobalKey<FormState>(); // Form key for Page2
  List<Heir> heirs = [
    Heir(name: 'Son', count: 0),
    Heir(name: 'Daughter', count: 0),
    Heir(name: 'Father', count: 0),
    Heir(name: 'Mother', count: 0),
    Heir(name: 'Full Brother', count: 0),
    Heir(name: 'Full Sister', count: 0),
    Heir(name: 'Husband', count: 0),
    Heir(name: 'Wife', count: 0),
  ];

  int _currentPage = 0;

  void _goToNextPage() {
    setState(() {
      if (_currentPage < pages.length - 1) {
        _currentPage++;
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  bool _validatePage(int pageIndex) {
    if (pageIndex == 0) {
      return _page1FormKey.currentState?.validate() ?? false;
    } else if (pageIndex == 1) {
      return _page2FormKey.currentState?.validate() ?? false;
    }
    return true;
  }

  void _calculateInheritance() {
    print("///////////////////////////  " + _husbanStatusValue.toString());
    var sons = heirs[0].count;
    var daughters = heirs[1].count;
    var fatherExists = _fatherStatusValue;
    var motherExists = _motherStatusValue;
    var fullBrothers = heirs[4].count;
    var sister = heirs[5].count;
    var husband = _husbanStatusValue;
    var wife = _wifeStatusValue;

    double husbandShare = 0.0;
    double wifeShare = 0.0;
    double daughterShare = 0.0;
    double fatherShare = 0.0;
    double motherShare = 0.0;
    double sonShare = 0.0;
    double fullBrotherShare = 0.0;
    double fullSisterShare = 0.0;
    double remain = 0.0;

    // Calculate husband's share
    if (sons == 0 && daughters == 0) {
      husbandShare = 0.5 * husband * double.parse(_totalAmountController.text);
    } else {
      husbandShare = 0.25 * husband * double.parse(_totalAmountController.text);
    }
    // Calculate wife's share
    if (sons == 0 && daughters == 0) {
      wifeShare = 0.25 * wife * double.parse(_totalAmountController.text);
    } else {
      wifeShare = 0.125 * wife * double.parse(_totalAmountController.text);
    }

// Calculate father's share
    if (sons == 0 && daughters == 0 && (husband == 0 || wife == 0)) {
      if (motherExists == 1) {
        fatherShare = (double.parse(_totalAmountController.text) -
                (double.parse(_totalAmountController.text) * 1 / 3)) *
            fatherExists;
      } else {
        fatherShare = double.parse(_totalAmountController.text) * fatherExists;
      }
    } else {
      fatherShare =
          double.parse(_totalAmountController.text) * (1 / 6) * fatherExists;
    }

    // Calculate mother's share

    if ((sons > 0 || daughters > 0) || fullBrothers > 1) {
      motherShare =
          motherExists * double.parse(_totalAmountController.text) * (1 / 6);
    } else {
      motherShare =
          motherExists * double.parse(_totalAmountController.text) * (1 / 3);
    }

    var total = fatherShare + motherShare + husbandShare + wifeShare;
    remain = double.parse(_totalAmountController.text) - total;
    int sondaughtershares = (2 * sons) + daughters;
// Calculate son's share
    if (sons > 0 && daughters == 0) {
      sonShare = remain / sons;
    } else if (sons > 1 && daughters == 0) {
      sonShare = remain / ((2 * sons) + daughters);
    } else if (sons >= 1 && daughters >= 1) {
      sonShare = ((remain / sondaughtershares * 2)) * sons;
    }

    // Calculate daughter's share
    if (daughters == 1 && sons == 0) {
      daughterShare = 0.5 * remain;
    } else if (daughters > 1 && sons == 0) {
      daughterShare = (2 / 3) * remain;
    } else if (daughters >= 1 && sons >= 1) {
      daughterShare = (remain / sondaughtershares) * daughters;
    }
    // Calculate full sister's share
    if (daughters == 0 && sons == 0 && fullBrothers == 0 && sister == 1) {
      fullSisterShare = 0.5 * remain;
    } else if (daughters == 0 && sons == 0 && fullBrothers == 0 && sister > 1) {
      fullSisterShare = (2 / 3) * remain;
    } else if (daughters == 0 &&
        sons == 0 &&
        fullBrothers >= 1 &&
        sister >= 1) {
      fullSisterShare = (remain / ((2 * fullBrothers) + daughters)) * sister;
    }
    // Calculate daughter's share
    if (daughters == 0 && sons == 0 && fullBrothers == 1 && sister == 0) {
      sonShare = remain / sons;
    } else if (daughters == 0 &&
        sons == 0 &&
        fullBrothers >= 1 &&
        sister == 0) {
      sonShare = remain / ((2 * fullBrothers) + daughters);
    } else if (daughters == 0 &&
        sons == 0 &&
        fullBrothers >= 1 &&
        sister >= 1) {
      sonShare = ((remain / ((2 * fullBrothers) + daughters) * 2)) * sons;
    }

    // Create a map of inheritance values
    Map<String, dynamic> inheritanceValues = {
      'heirs': [
        {'name': 'Husband Share', 'share': husbandShare},
        {'name': 'Wife Share', 'share': wifeShare},
        {'name': 'Son Share', 'share': sonShare},
        {'name': 'Daughter Share', 'share': daughterShare},
        {'name': 'Father Share', 'share': fatherShare},
        {'name': 'Mother Share', 'share': motherShare},
        {'name': 'Full Brother Share', 'share': fullBrotherShare},
        {'name': 'Full Sister Share', 'share': fullSisterShare},
      ],
    };
    print("=======================" + inheritanceValues.toString());
    // Navigate to the InheritanceResultScreen and pass the inheritance values
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => result.InheritanceScreen(
          jsonData: jsonEncode(inheritanceValues),
          totalvalue: (double.parse(_totalAmountController.text) -
                  double.parse(_loanAmountController.text) -
                  double.parse(_willAmountController.text))
              .toString(),
          loadAmount: _loanAmountController.text,
          willAmount: _willAmountController.text,
          name: _deceasedNameController.text,
          gender: _selectedGender.toString(),
        ),
      ),
    );
  }

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      Page1(
        formKey: _page1FormKey,
        deceasedNameController: _deceasedNameController,
        selectedGender: _selectedGender,
      ),
      Page2(
        formKey: _page2FormKey,
        totalAmountController: _totalAmountController,
        loanAmountController: _loanAmountController,
        willAmountController: _willAmountController,
      ),
      Page3(heirs: heirs),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DhaxalXisaab'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0) // Add this condition
              ElevatedButton(
                onPressed: _goToPreviousPage,
                child: Text('Previous'),
              ),
            if (_currentPage == pages.length - 1) // Add this condition
              ElevatedButton(
                onPressed: _calculateInheritance,
                child: Text('Calculate'),
              ),
            if (_currentPage < pages.length - 1) // Add this condition
              ElevatedButton(
                onPressed: () {
                  if (_validatePage(_currentPage)) {
                    _goToNextPage();
                  }
                },
                child: Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController deceasedNameController;
  final Gender selectedGender;

  Page1({
    required this.formKey,
    required this.deceasedNameController,
    required this.selectedGender,
  });

  final List<DropdownMenuItem<Gender>> genderItems = [
    DropdownMenuItem<Gender>(
      value: Gender.male,
      child: Text('Male'),
    ),
    DropdownMenuItem<Gender>(
      value: Gender.female,
      child: Text('Female'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deceased Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: deceasedNameController,
              decoration: InputDecoration(
                label: Text("Name"),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the deceased name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<Gender>(
              value: selectedGender,
              items: genderItems,
              onChanged: (value) {
                // Handle gender selection
              },
              decoration: InputDecoration(
                labelText: 'Gender',
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please select a gender';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController totalAmountController;
  final TextEditingController loanAmountController;
  final TextEditingController willAmountController;

  Page2({
    required this.formKey,
    required this.totalAmountController,
    required this.loanAmountController,
    required this.willAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: totalAmountController,
              decoration: InputDecoration(
                labelText: 'Total Amount',
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the total amount';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: loanAmountController,
              decoration: InputDecoration(
                  labelText: 'Loan Amount',
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the loan amount';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: willAmountController,
              decoration: InputDecoration(
                  labelText: 'Will Amount',
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the will amount';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  final List<Heir> heirs;

  Page3({required this.heirs});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  // Default value is 1, which means "Alive."

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Add SingleChildScrollView here
      child: ConstrainedBox(
        // Add ConstrainedBox to give it a height
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height, // Set a minimum height
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Heirs Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Is Father Live",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              ListTile(
                title: const Text('Yes'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 1,
                  groupValue: _fatherStatusValue,
                  onChanged: (value) {
                    setState(() {
                      _fatherStatusValue = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 0,
                  groupValue: _fatherStatusValue,
                  onChanged: (value) {
                    setState(() {
                      _fatherStatusValue = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text(
                "Is Mother Live",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              ListTile(
                title: const Text('Yes'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 1,
                  groupValue: _motherStatusValue,
                  onChanged: (value) {
                    setState(() {
                      _motherStatusValue = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 0,
                  groupValue: _motherStatusValue,
                  onChanged: (value) {
                    setState(() {
                      _motherStatusValue = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "who is died",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              ListTile(
                title: const Text('Husban'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 1,
                  groupValue: _husbanStatusValue,
                  onChanged: (value) {
                    setState(() {
                      if (value == 1) {
                        _husbanStatusValue = 1;
                        _wifeStatusValue = 0;
                      } else {
                        _husbanStatusValue = 0;
                        _wifeStatusValue = 1;
                      }
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Wife'),
                leading: Radio(
                  // Change the generic type argument to int
                  value: 0,
                  groupValue: _husbanStatusValue,
                  onChanged: (value) {
                    setState(() {
                      if (value == 0) {
                        _husbanStatusValue = 0;
                        _wifeStatusValue = 1;
                      } else {
                        _husbanStatusValue = 1;
                        _wifeStatusValue = 0;
                      }
                    });
                  },
                ),
              ),
              Text(
                'Fill the number another  heirs:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              ListView.separated(
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                shrinkWrap: true,
                itemCount: widget.heirs.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(widget.heirs[index].name),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (widget.heirs[index].count > 0) {
                              widget.heirs[index].count--;
                            }
                          });
                        },
                      ),
                      Text(widget.heirs[index].count.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.heirs[index].count++;
                          });
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Heir {
  String name;
  int count;

  Heir({required this.name, required this.count});
}
