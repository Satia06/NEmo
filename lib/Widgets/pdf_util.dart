import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:nemo/providers/entity_provider.dart';
import 'dart:math';

Future<Uint8List> _generatePdf(
    var entityProvider, PdfPageFormat format, String title) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  List<String>? entityNames = entityProvider;
  final font = await PdfGoogleFonts.nunitoExtraLight(); //
  int currentIndex = 0;
  double fontSize = 15.0, padding = 5.0;

  while (currentIndex < entityNames!.length) {
    final height = format.availableHeight;
    final numEntities = ((height - 100) / (fontSize + padding)).floor();
    final end = min(currentIndex + numEntities, entityNames.length);
    List<String> names = entityNames.sublist(currentIndex, end);
    currentIndex = end;
    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(
                  left: format.availableWidth / 2, top: 50.0, bottom: 50.0),
              child: pw.Column(
                children: List.generate(
                    names.length,
                    (index) => pw.Padding(
                        padding: pw.EdgeInsets.only(bottom: padding),
                        child: pw.Text(names[index],
                            style: pw.TextStyle(
                              font: font,
                              fontSize: fontSize,
                            )))),
              ));
        }));
  }

  // pdf.addPage(
  //   pw.Page(
  //     pageFormat: format,
  //     build: (context) {
  //       return pw.Column(
  //         // children: [
  //         //   pw.SizedBox(height: 20),
  //         //   pw.Flexible(child: pw.FlutterLogo())
  //         // ],
  //         children: List.generate(
  //           100,
  //           (index) => pw.SizedBox(
  //             width: double.infinity,
  //             child: pw.FittedBox(
  //               child: pw.Text("Stupid Text", style: pw.TextStyle(font: font)),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  // );

  return pdf.save();
}

class PdfUtil extends StatelessWidget {
  List entityProvider;
  PdfUtil({required this.entityProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(),
      ),
      body: PdfPreview(
        build: (format) =>
            _generatePdf(entityProvider, format, "List Of Entities"),
      ),
    );
  }
}
