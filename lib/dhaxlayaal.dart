import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Heir {
  final String name;
  double share;

  Heir(this.name, this.share);

  Heir.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        share = double.parse(json['share'].toString());

  Map<String, dynamic> toJson() => {
        'name': name,
        'share': share,
      };
}

class InheritanceScreen extends StatefulWidget {
  final String jsonData;

  const InheritanceScreen({Key? key, required this.jsonData}) : super(key: key);

  @override
  _InheritanceScreenState createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
  late List<Heir> heirs;

  @override
  void initState() {
    super.initState();
    var jsonData = json.decode(widget.jsonData);
    heirs = List<Heir>.from(jsonData['heirs'].map((x) => Heir.fromJson(x)));
    calculateIslamicInheritance();
  }

  void calculateIslamicInheritance() {
    final double estateValue = 100000; // Example estate value

    // Define the shares for each heir
    double son = 2;
    double daughter = 1;
    double wife = 1;
    double brother = 1;
    double sister = 1;
    double father = 1;
    double mother = 1;
    double uncle = 1;
    double husband = 1;

    final List<Heir> calculatedInheritance = calculateInheritance(
      estateValue,
      son,
      daughter,
      wife,
      brother,
      sister,
      father,
      mother,
      uncle,
      husband,
    );

    setState(() {
      heirs = calculatedInheritance;
    });
  }

  List<Heir> calculateInheritance(
    double estateValue,
    double son,
    double daughter,
    double wife,
    double brother,
    double sister,
    double father,
    double mother,
    double uncle,
    double husband,
  ) {
    final List<Heir> heirs = [
      Heir('Son', son),
      Heir('Daughter', daughter),
      Heir('Wife', wife),
      Heir('Brother', brother),
      Heir('Sister', sister),
      Heir('Father', father),
      Heir('Mother', mother),
      Heir('Uncle', uncle),
      Heir('Husband', husband),
    ];

    // Remove heirs with zero shares
    heirs.removeWhere((heir) => heir.share == 0);

    // Calculate total shares
    double totalShares = heirs.fold<double>(0, (prev, curr) => prev + curr.share);

    // Check if Islamic inheritance rules are followed
    bool isValidInheritance = validateIslamicInheritance(heirs);
    if (!isValidInheritance) {
      return [];
    }

    // If total shares are less than 1, distribute the remaining share among eligible relatives
    if (totalShares < 1) {
      distributeRemainingShare(heirs, 1 - totalShares);
      totalShares = 1;
    }

    // Adjust shares proportionally if total shares exceed 1
    if (totalShares > 1) {
      heirs.forEach((heir) {
        heir.share = heir.share / totalShares;
      });
      totalShares = 1;
    }

    // Calculate inheritance for each heir
    final List<Heir> inheritance = [];
    heirs.forEach((heir) {
      double amount = double.parse((estateValue * heir.share).toStringAsFixed(2));
      inheritance.add(Heir(heir.name, double.parse(amount.toStringAsFixed(2))));
    });

    return inheritance;
  }

  bool validateIslamicInheritance(List<Heir> heirs) {
    final List<String> femaleHeirs = ['Daughter', 'Wife', 'Sister', 'Mother'];

    for (int i = 0; i < heirs.length; i++) {
      if (femaleHeirs.contains(heirs[i].name)) {
        for (int j = 0; j < heirs.length; j++) {
          if (heirs[j].name == 'Son' || heirs[j].name == 'Brother' || heirs[j].name == 'Father' || heirs[j].name == 'Uncle' || heirs[j].name == 'Husband') {
            if (heirs[i].share > heirs[j].share) {
              return false;
            }
          }
        }
      }
    }

    return true;
  }

  void distributeRemainingShare(List<Heir> heirs, double remainingShare) {
    for (int i = 0; i < heirs.length; i++) {
      if (heirs[i].name == 'Son' || heirs[i].name == 'Brother' || heirs[i].name == 'Father' || heirs[i].name == 'Uncle' || heirs[i].name == 'Husband') {
        heirs[i].share += remainingShare;
        break;
      }
    }
  }

  Future<void> _printDocument() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoExtraBold();

    pdf.addPage(
      pw.MultiPage(
        header: (pw.Context context) => pw.Text(
          'Dhaxal Xisaab',
          style: pw.TextStyle(
            font: font,
            fontSize: 35,
          ),
        ),
        footer: (pw.Context context) => pw.Positioned(
          bottom: 0,
          right: 0,
          child: pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(
              font: font,
              fontSize: 28,
            ),
          ),
        ),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Heirs and their shares',
              style: pw.TextStyle(
                font: font,
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Table.fromTextArray(
            headers: ['Heir', 'Share'],
            cellStyle: pw.TextStyle(
              font: font,
              fontSize: 20,
            ),
            headerStyle: pw.TextStyle(
              font: font,
              fontSize: 25,
              fontWeight: pw.FontWeight.bold,
            ),
            data: [
              ...heirs.map(
                (heir) => [heir.name, '\$ ${heir.share.toStringAsFixed(2)}'],
              ),
            ],
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inheritance Information'),
        actions: [
          IconButton(
            onPressed: _printDocument,
            icon: Icon(Icons.print),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Heirs and their shares:',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: heirs.length,
              itemBuilder: (context, index) {
                final heir = heirs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${heir.name}:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$ ${heir.share.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
