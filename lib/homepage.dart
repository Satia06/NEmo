import 'package:flutter/material.dart';
import 'package:nemo/Widgets/menubutton.dart';
import 'package:nemo/drivenew/googledrive.dart';
import 'package:nemo/Widgets/expansionSearchBar.dart';
import 'package:nemo/getsearchlist.dart';
import 'dart:io';
import 'package:nemo/providers/search_provider.dart';
import 'package:nemo/Widgets/expansionSearchBar.dart';
import 'package:provider/provider.dart';
import 'package:nemo/screens/list_of_entities.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/sheets/v4.dart' as SheetsV4;
import 'package:url_launcher/url_launcher.dart';
import 'package:gsheets/gsheets.dart';
import 'package:nemo/screens/signinpage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';
import 'package:nemo/drivenew/load_document.dart';
import 'package:nemo/screens/documentPage.dart';
import 'package:nemo/Widgets/pdf_util.dart';

bool isSearching = false;

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

  // late DriveProvider driveProvider;
  // late EntityProvider entityProvider;

  // DriveUtils _driveUtils = DriveUtils();
  ///
  ///
  ///
  ///
  /// A function that takes a string input from the user which is the location of folder which has videos
  ///  videoFolderPath <= update this variable
  ///
  void printList() {
    List<String> entitiesList = [];
    for (int i = 0; i < widget._list.length; i++) {
      entitiesList.add(widget._list[i]["name"]);
    }
    entitiesList.reversed;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfUtil(entityProvider: entitiesList)));
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

  final drive = GoogleDrive();
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
    launch('https://forms.gle/Bgz1YedkJygnbUZY7');
  }

  void _close() {
    exit(0);
  }

///////////////////////
  final TextEditingController _controller = new TextEditingController();
  String _searchText = "";
  bool _load = false;
///////////////////////

  _HomePageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    // driveProvider = Provider.of<DriveProvider>(context, listen: false);
    // entityProvider = Provider.of<EntityProvider>(context, listen: false);
    // driveProvider.driveUtils.init(context);
    super.initState();
    isSearching = false;
    _load = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? Container(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              value: null,
                              strokeWidth: 7.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Text(
                              "loading.. wait...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
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
                          //TextButton(
                          //     onPressed: () async {
                          //       //call getsearchlist function to refresh our list
                          //     },
                          //     child: Text('Press for sheet data')),
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
                                  builder: (context) => ListOfEntities(
                                      widget._list, widget._client)),
                            );
                            //await drive.upload();
                          },
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
                        Container(
                          width: MediaQuery.of(context).size.width / 2 > 600
                              ? 600
                              : MediaQuery.of(context).size.width / 2,
                          child: TextField(
                            controller: _controller,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                            decoration: new InputDecoration(
                                prefixIcon:
                                    new Icon(Icons.search, color: Colors.white),
                                hintText: "Search...",
                                hintStyle: new TextStyle(color: Colors.white)),
                            onChanged: searchOperation,
                          ),
                          color: Colors.white.withOpacity(0.16),
                        ),
                        Container(
                          //color: Colors.white.withOpacity(0.16),
                          width: MediaQuery.of(context).size.width / 2 > 600
                              ? 600
                              : MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 1.8,
                          child: searchdata.length != 0 &&
                                  _controller.text.isNotEmpty
                              ? new ListView.builder(
                                  //shrinkWrap: true,
                                  itemCount: searchdata.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String liststring = searchdata[index][1]; //
                                    return Card(
                                      elevation: 1.0,
                                      color: Colors.white.withOpacity(0.16),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1.0,
                                            color:
                                                Colors.blue.withOpacity(0.2)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: new ListTile(
                                        onTap: () async {
                                          print(
                                              "checking to see if we find matching name");
                                          for (int j = 0;
                                              j < widget._list.length;
                                              j++) {
                                            if (widget._list[j]["name"]
                                                .toLowerCase()
                                                .contains(searchdata[index][0]
                                                    .toLowerCase())) {
                                              setState(() {
                                                _load = true;
                                              });
                                              var _list;
                                              _list =
                                                  await drive.fileListFuntion(
                                                      widget._list[j]["id"],
                                                      widget._client);
                                              await loadDocument(
                                                  _list, widget._client);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocumentPage(
                                                            description,
                                                            traits,
                                                            title,
                                                            someList,
                                                            widget._client,
                                                            videoFolder)),
                                              );
                                              //print(_list);
                                              // print(_list[0]["id"]);/
                                              setState(() {
                                                _load = false;
                                              });
                                            }
                                          }
                                          //tell that it doesnt match in case nothing is put out
                                        },
                                        title: new Text(liststring.toString()),
                                      ),
                                    );
                                  },
                                )
                              : ListTile(
                                  title: Text("No results found"),
                                ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
          Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          )
        ],
      ),
    );
  }
}
