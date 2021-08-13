import 'package:flutter/material.dart';
import 'package:nemo/Widgets/menubutton.dart';
import 'package:nemo/drivenew/googledrive.dart';
import 'package:nemo/Widgets/searchbar.dart';
import 'dart:io';
import 'package:nemo/providers/search_provider.dart';
import 'package:nemo/Widgets/expansionSearchBar.dart';
import 'package:provider/provider.dart';
import 'package:nemo/screens/list_of_entities.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:nemo/screens/signinpage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomePage extends StatefulWidget {
  var _client;
  var _list;
  HomePage(this._client, this._list);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final doc = pw.Document();
  void emptyFunction() {
    return;
  }

  void printList() {
    print("print called");
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        }));
    doc.save();
  }

  Future _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Placeholder(),
      ),
    );

    return pdf.save();
  }

  void listOfEntities() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListOfEntities(widget._list, widget._client)),
    );
  }

  void feedbackForm() {
    launch('www.google.com');
  }

  void _close() {
    exit(0);
  }

  final drive = GoogleDrive();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/3.jpg",
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MenuButton(
                              buttonName: 'File',
                              names: ['Print', 'Close'],
                              submenuFunctions: [printList, _close]),
                          MenuButton(
                              buttonName: 'Edit',
                              names: ['Add/Modify'],
                              submenuFunctions: [_generatePdf]),
                          MenuButton(
                              buttonName: 'View',
                              names: ['List'],
                              submenuFunctions: [listOfEntities]),
                          MenuButton(
                              buttonName: 'Help',
                              names: ['Feedback'],
                              submenuFunctions: [feedbackForm])
                        ],
                      ),
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        //print("asdfksahdf");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListOfEntities(widget._list, widget._client)),
                        );
                        //await drive.upload();
                      },
                      /////////////////////////////////

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "List of Entities",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    ChangeNotifierProvider(
                      create: (context) => SearchProvider(),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 > 600
                            ? 600
                            : MediaQuery.of(context).size.width / 2,
                        child: ExpansionSearchBar(tooltip: "Search here!"),
                        color: Colors.white.withOpacity(0.16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
                //Expanded(
                //child: Container(
                //color: Colors.white,
                //),
                //)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
