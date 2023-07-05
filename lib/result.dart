import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

class Heir {
  final String name;
  final double share;

  Heir(this.name, this.share);

  Heir.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        share = double.parse(json['share'].toString());
}

class InheritanceScreen extends StatelessWidget {
  final List<Heir> heirs;

  const InheritanceScreen({Key? key, required this.heirs}) : super(key: key);

  Future<void> _printDocument() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Nunito-ExtraBold.ttf');
    final font = pw.Font.ttf(fontData);

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
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Heirs and Their Shares',
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
                'Heirs and Their Shares:',
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
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
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
        ));
  }
}
