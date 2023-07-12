import 'package:flutter/material.dart';
import 'dart:convert';
import 'result.dart' as result;

enum Gender { male, female }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inheritance Calculator',
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
    var sons = heirs[0].count;
    var daughters = heirs[1].count;
    var fatherExists = heirs[2].count;
    var motherExists = heirs[3].count;
    var fullBrothers = heirs[4].count;
    var sister = heirs[5].count;
    var husband = heirs[6].count;
    var wife = heirs[7].count;

    double husbandShare = 0.0;
    double wifeShare = 0.0;
    double daughterShare = 0.0;
    double fatherShare = 0.0;
    double motherShare = 0.0;
    double sonDaughterShare = 0.0;
    double fullBrotherShare = 0.0;
    double fullSisterShare = 0.0;

    print(wife);

    // Calculate husband's share
    if (sons == 0 && daughters == 0) {
      husbandShare = 0.5 * double.parse(_totalAmountController.text);
    } else {
      husbandShare = 0.25 * double.parse(_totalAmountController.text);
    }
    // Calculate wife's share
    if (sons == 0 && daughters == 0) {
      wifeShare = 0.25;
    } else {
      wifeShare = 0.125 * double.parse(_totalAmountController.text);
    }

    // Calculate daughter's share
    daughterShare = (1 / (sons + daughters)) *
        (0.5 - husbandShare - wifeShare) *
        double.parse(_totalAmountController.text);

    // Calculate father's share
    fatherShare = (1 / (sons + daughters)) *
        (0.125 - wifeShare) *
        double.parse(_totalAmountController.text);

    // Calculate mother's share
    motherShare = (1 / (sons + daughters)) *
        (0.125 - wifeShare) *
        double.parse(_totalAmountController.text);

    // Calculate son/daughter share
    sonDaughterShare = (1 / (sons + daughters)) *
        0.5 *
        double.parse(_totalAmountController.text);

    // Calculate full brother's share
    if (fullBrothers > 0) {
      fullBrotherShare = (1 / fullBrothers) *
          sonDaughterShare *
          double.parse(_totalAmountController.text);
    }

    // Calculate full sister's share
    if (sister > 0) {
      fullSisterShare = (1 / sister) *
          sonDaughterShare *
          double.parse(_totalAmountController.text);
    }

    // Create a map of inheritance values
    Map<String, dynamic> inheritanceValues = {
      'heirs': [
        {'name': 'Husband Share', 'share': husbandShare},
        {'name': 'Wife Share', 'share': wifeShare},
        {'name': 'Daughter Share', 'share': daughterShare},
        {'name': 'Father Share', 'share': fatherShare},
        {'name': 'Mother Share', 'share': motherShare},
        {'name': 'Full Brother Share', 'share': fullBrotherShare},
        {'name': 'Full Sister Share', 'share': fullSisterShare},
      ],
    };

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
        title: Text('Inheritance Calculator'),
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

class Page3 extends StatelessWidget {
  final List<Heir> heirs;

  Page3({required this.heirs});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            'Enter the number of heirs:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: heirs.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(heirs[index].name),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (heirs[index].count > 0) {
                        heirs[index].count--;
                      }
                    },
                  ),
                  Text(heirs[index].count.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      heirs[index].count++;
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class Heir {
  String name;
  int count;

  Heir({required this.name, required this.count});
}
