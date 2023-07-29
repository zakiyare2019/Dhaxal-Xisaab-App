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
  final String name;
  final String gender;
  final String totalvalue;
  final String loadAmount;
  final String willAmount;

  const InheritanceScreen(
      {Key? key,
      required this.jsonData,
      required this.name,
      required this.gender,
      required this.totalvalue,
      required this.loadAmount,
      required this.willAmount})
      : super(key: key);

  @override
  _InheritanceScreenState createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
  late List<Heir> heirs;

  @override
  void initState() {
    super.initState();
    try {
      var jsonData = json.decode(widget.jsonData);
      heirs = List<Heir>.from(jsonData['heirs'].map((x) => Heir.fromJson(x)));
    } catch (e) {
      heirs = [];
    }
  }

  Future<void> _printDocument() async {
    final pdf = pw.Document();
    // final font = await PdfGoogleFonts.nunitoExtraBold();
    final font = await pw.Font.courierBoldOblique();

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
            'Boga ${context.pageNumber}',
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
          pw.Header(
            level: 2,
            child: pw.Text(
              'Date: ${DateTime.now().toString()}',
              style: pw.TextStyle(
                font: font,
                fontSize: 20,
              ),
            ),
          ),
          pw.Header(
            level: 2,
            child: pw.Text(
              'Name: ' + widget.name,
              style: pw.TextStyle(
                font: font,
                fontSize: 20,
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
