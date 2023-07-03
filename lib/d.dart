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
  TextEditingController _propertyTypeController = TextEditingController();
  TextEditingController _loanAmountController = TextEditingController();
  TextEditingController _leftBehindItemsController = TextEditingController();
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
        _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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
    print('Property Type: ${_propertyTypeController.text}');
    print('Loan Amount: ${_loanAmountController.text}');
    print('Left Behind Items: ${_leftBehindItemsController.text}');
    print('Number of Children: ${_numberOfChildrenController.text}');
    print('Number of Siblings: ${_numberOfSiblingsController.text}');
    print('Has Will: ${_hasWillController.text}');
    print('Debt Amount: ${_debtAmountController.text}');
    for (var heir in heirs) {
      print('${heir.name}: ${heir.count}');
    }
  }

  List<Widget> pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

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
            ElevatedButton(
              onPressed: _goToPreviousPage,
              child: Text('Previous'),
            ),
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
              child: _currentPage == pages.length - 1 ? Text('Calculate') : Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final TextEditingController _deceasedNameController = TextEditingController();
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
          Text('Deceased Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            controller: _deceasedNameController,
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
            value: Gender.male,
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
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _leftBehindItemsController = TextEditingController();
  final TextEditingController _numberOfChildrenController = TextEditingController();
  final TextEditingController _numberOfSiblingsController = TextEditingController();
  final TextEditingController _hasWillController = TextEditingController();
  final TextEditingController _debtAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inheritance Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            controller: _propertyTypeController,
            decoration: InputDecoration(
              labelText: 'Property Type',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the property type';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _loanAmountController,
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
            controller: _leftBehindItemsController,
            decoration: InputDecoration(
              labelText: 'Left Behind Items',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the left behind items';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  final List<Heir> heirs = [
    Heir(name: 'Son', count: 0),
    Heir(name: 'Daughter', count: 0),
    Heir(name: 'Father', count: 0),
    Heir(name: 'Mother', count: 0),
    Heir(name: 'Full Brother', count: 0),
    Heir(name: 'Full Sister', count: 0),
    Heir(name: 'Husband', count: 0),
    Heir(name: 'Wife', count: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Heirs Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: heirs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(heirs[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Decrement count
                        // You can also add validation to prevent negative count
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(heirs[index].count.toString()),
                    IconButton(
                      onPressed: () {
                        // Increment count
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Heir {
  final String name;
  int count;

  Heir({required this.name, required this.count});
}

