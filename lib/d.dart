import 'package:flutter/material.dart';

enum Gender { male, female }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inheritance Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  void _calculateInheritance() {
    // Perform the inheritance calculation using the collected data
    // and display the result to the user
    // You can access the collected data using the TextEditingController instances
    // and other variables
    // For simplicity, let's just print the data to the console for now
    print('Deceased Name: ${_deceasedNameController.text}');
    print('Gender: $_selectedGender');
    print('Property Type: ${_totalAmountController.text}');
    print('Loan Amount: ${_loanAmountController.text}');
    print('Left Behind Items: ${_willAmountController.text}');
    print('Number of Children: ${_numberOfChildrenController.text}');
    print('Number of Siblings: ${_numberOfSiblingsController.text}');
    print('Has Will: ${_hasWillController.text}');
    print('Debt Amount: ${_debtAmountController.text}');
    for (var heir in heirs) {
      print('${heir.name}: ${heir.count}');
    }
  }

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      Page1(
        deceasedNameController: _deceasedNameController,
        selectedGender: _selectedGender,
      ),
      Page2(
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
            if (_currentPage == 0) // Add this condition
              SizedBox(width: 80), // Empty container to maintain spacing
            ElevatedButton(
              onPressed: () {
                if (_currentPage == pages.length - 1) {
                  // Last page, perform calculation
                  _calculateInheritance();
                } else {
                  // Not the last page, go to next page
                  _goToNextPage();
                }
              },
              child: _currentPage == pages.length - 1
                  ? TextButton(onPressed: null, child: Text("calculate"))
                  : Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final TextEditingController deceasedNameController;
  final Gender selectedGender;

  Page1({required this.deceasedNameController, required this.selectedGender});

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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deceased Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            controller: deceasedNameController,
            decoration: InputDecoration(
              labelText: 'Name',
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
            onChanged: (value) {
              // Handle gender selection
            },
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
            items: genderItems,
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final TextEditingController totalAmountController;
  final TextEditingController loanAmountController;
  final TextEditingController willAmountController;

  Page2({
    required this.totalAmountController,
    required this.loanAmountController,
    required this.willAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inheritance Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            controller: totalAmountController,
            decoration: InputDecoration(
              labelText: 'Total Amount',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Total Amount';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: loanAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Loan Amount',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the loan amount';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: willAmountController,
            decoration: InputDecoration(
              labelText: 'Will Amount',
            ),
            validator: (value) {
              var f = double.parse(totalAmountController.text) -
                  double.parse(loanAmountController.text) * (1 / 3);
              if (value == null || value.isEmpty) {
                return 'Please enter the will Amount';
              }
              if (double.parse(willAmountController.text) >= f) {
                return 'The will Amount not greater than one third';
              }
              return null;
            },
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Heirs Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: widget.heirs.length,
              itemBuilder: (context, index) {
                return HeirRow(
                  heir: widget.heirs[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Heir {
  final String name;
  int count;

  Heir({required this.name, this.count = 0});
}

class HeirRow extends StatefulWidget {
  final Heir heir;

  HeirRow({required this.heir});

  @override
  _HeirRowState createState() => _HeirRowState();
}

class _HeirRowState extends State<HeirRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(widget.heir.name)),
        IconButton(
          onPressed: () {
            setState(() {
              if (widget.heir.count > 0) {
                widget.heir.count--;
              }
            });
          },
          icon: Icon(Icons.remove),
        ),
        Text(widget.heir.count.toString()),
        IconButton(
          onPressed: () {
            setState(() {
              widget.heir.count++;
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
