import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamic Inheritance Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final List<Heir> heirs = [
    Heir(name: 'Son'),
    Heir(name: 'Daughter'),
    Heir(name: 'Father'),
    Heir(name: 'Mother'),
    Heir(name: 'Brother'),
    Heir(name: 'Sister'),
    Heir(name: 'Husband'),
    Heir(name: 'Wife'),
  ];

  Gender deceasedGender = Gender.male;
  List<CalculationResult> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DhaxalXisaab'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deceased Gender:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Radio(
                  value: Gender.male,
                  groupValue: deceasedGender,
                  onChanged: (value) {
                    setState(() {
                      deceasedGender = Gender.male;
                    });
                  },
                ),
                Text('Male'),
                SizedBox(width: 16),
                Radio(
                  value: Gender.female,
                  groupValue: deceasedGender,
                  onChanged: (value) {
                    setState(() {
                      deceasedGender = Gender.female;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Heirs:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: heirs.length,
                itemBuilder: (context, index) {
                  return HeirItem(
                    heir: heirs[index],
                    onChanged: (value) {
                      setState(() {
                        heirs[index].count = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  calculateHeirs();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(results: results, appName: "Dhaxal xisaab", printedDate: DateTime.now())
                    ),
                  );
                },
                child: Text('Calculate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateHeirs() {
    results.clear();

    // Total counts of all heirs
    int totalHeirsCount = heirs.fold(0, (sum, heir) => sum + heir.count);

    // Calculate inheritance shares based on Islamic Sharia Law
    if (deceasedGender == Gender.male) {
      int sonCount = heirs[0].count;
      int daughterCount = heirs[1].count;
      int wifeCount = heirs[7].count;
      int fullBrotherCount = heirs[4].count;
      int fullSisterCount = heirs[5].count;

      // Calculate shares for each heir type
      double sonShare = (sonCount * 2) / (totalHeirsCount + sonCount);
      double daughterShare = daughterCount / (totalHeirsCount + sonCount);
      double wifeShare = wifeCount / (totalHeirsCount + sonCount);
      double fatherShare = 1 / 6;
      double motherShare = 1 / 6;
      double fullBrotherShare = fullBrotherCount / 3;
      double fullSisterShare = fullSisterCount / 6;

      // Create CalculationResult objects for each heir
      results.add(CalculationResult(heirs[0], sonShare));
      results.add(CalculationResult(heirs[1], daughterShare));
      results.add(CalculationResult(heirs[7], wifeShare));
      results.add(CalculationResult(heirs[2], fatherShare));
      results.add(CalculationResult(heirs[3], motherShare));
      results.add(CalculationResult(heirs[4], fullBrotherShare));
      results.add(CalculationResult(heirs[5], fullSisterShare));
    } else {
      int sonCount = heirs[0].count;
      int daughterCount = heirs[1].count;
      int husbandCount = heirs[6].count;
      int fullBrotherCount = heirs[4].count;
      int fullSisterCount = heirs[5].count;

      // Calculate shares for each heir type
      double sonShare = sonCount / (totalHeirsCount + daughterCount);
      double daughterShare = (daughterCount * 2) / (totalHeirsCount + daughterCount);
      double husbandShare = husbandCount / (totalHeirsCount + daughterCount);
      double fatherShare = 1 / 6;
      double motherShare = 1 / 6;
      double fullBrotherShare = fullBrotherCount / 3;
      double fullSisterShare = fullSisterCount / 6;

      // Create CalculationResult objects for each heir
      results.add(CalculationResult(heirs[0], sonShare));
      results.add(CalculationResult(heirs[1], daughterShare));
      results.add(CalculationResult(heirs[6], husbandShare));
      results.add(CalculationResult(heirs[2], fatherShare));
      results.add(CalculationResult(heirs[3], motherShare));
      results.add(CalculationResult(heirs[4], fullBrotherShare));
      results.add(CalculationResult(heirs[5], fullSisterShare));
    }
  }
}
class ResultsScreen extends StatelessWidget {
  final List<CalculationResult> results;
  final String appName;
  final DateTime printedDate;

  ResultsScreen({
    required this.results,
    required this.appName,
    required this.printedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              appName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Printed: ${formattedDate(printedDate)}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              generatePDF(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return ListTile(
                    title: Text(result.heir.name),
                    subtitle:
                        Text('Share: ${(result.share * 100).toStringAsFixed(2)}%'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    // Create the PDF content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Results:',
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 8),
                for (final result in results)
                  pw.Text(
                    '${result.heir.name}: ${(result.share * 100).toStringAsFixed(2)}%',
                  ),
              ],
            ),
          );
        },
      ),
    );

    // Get the document as a list of bytes
    final bytes = await pdf.save();

    // Print the document
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
    );
  }
}


class Heir {
  final String name;
  int count;

  Heir({required this.name, this.count = 0});
}

class CalculationResult {
  final Heir heir;
  final double share;

  CalculationResult(this.heir, this.share);
}

enum Gender {
  male,
  female,
}

class HeirItem extends StatelessWidget {
  final Heir heir;
  final ValueChanged<int> onChanged;

  HeirItem({required this.heir, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(heir.name)),
        IconButton(
          onPressed: () {
            onChanged(heir.count + 1);
          },
          icon: Icon(Icons.add),
        ),
        Text(heir.count.toString()),
        IconButton(
          onPressed: () {
            if (heir.count > 0) {
              onChanged(heir.count - 1);
            }
          },
          icon: Icon(Icons.remove),
        ),
      ],
    );
  }
}
