import 'package:flutter/material.dart';
import 'package:nemo/drivenew/googledrive.dart';
import 'documentPage.dart';
import 'package:nemo/drivenew/load_document.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;
import 'dart:ui';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
////
import 'dart:async';

import 'dart:typed_data';

final List<Widget> someList = [];
List traits = [];
var title;
var description;
var videoFolder;
var imageFolder;

class ListOfEntities extends StatefulWidget {
  List list1;
  var _client;
  ListOfEntities(this.list1, this._client);
  @override
  _ListOfEntitiesState createState() => _ListOfEntitiesState();
}

class _ListOfEntitiesState extends State<ListOfEntities> {
  @override
  final drive = GoogleDrive();

  bool _load = false;
  //var _maybeimage
  @override
  void initState() {
    // TODO: implement initState
    _load = false;
    super.initState();
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
                        TextButton(
                          child: Text('Back'),
                          onPressed: () => Navigator.pop(context), //_load=false
                        )
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
        Row(
          children: [
            Container(
                height: double.infinity,
                //color: Colors.grey,
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "List Of Entities",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                          var item = widget.list1[index]; //_list[index];
                          return Card(
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: Colors.blue.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.white.withOpacity(0.8),
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  _load = true;
                                });
                                var _list;
                                _list = await drive.fileListFuntion(
                                    widget.list1[index]["id"], widget._client);
                                await loadDocument(_list, widget._client);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DocumentPage(
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
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item["name"],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                        itemCount: widget.list1.length, //_list.length,
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ],
                )),
            Container(
              height: double.infinity,
              color: Colors.black45,
              width: MediaQuery.of(context).size.width * 2 / 3,
            ),
          ],
        ),
        Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    ));
  }
}
