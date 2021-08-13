import 'package:flutter/material.dart';
import 'package:nemo/drivenew/googledrive.dart';
import 'documentPage.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;
import 'dart:ui';

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
  final List<Widget> someList = [];
  List _traits = [];
  var _title;
  var _description;
  bool _load = false;
  //var _maybeimage;
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
                                await _loadDocument(_list);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DocumentPage(
                                          _description,
                                          _traits,
                                          _title,
                                          someList)),
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

  Future<void> _loadDocument(List _ofFileId) async {
    someList.clear();
    _traits.clear();
    final docsApi = docsV1.DocsApi(widget._client);
    var document = await docsApi.documents.get(_ofFileId[0]["id"]);
    //print('document.title: ${document.body}');
    _title = document.title;
    _description =
        document.body!.content![4].paragraph?.elements![0].textRun!.content;
    for (var i = 7; i < document.body!.content!.length; i++) {
      _traits.add(
          document.body!.content![i].paragraph?.elements![0].textRun!.content);
    }
    print(_traits.length);
    print("deletethis>" + _traits[3]);
    _traits.removeWhere((value) => value == "\n");
    print(_traits.length);
    print(_traits);
    var _temp;
    var _length;
    if (_ofFileId[1]["name"] == "images") {
      _temp = await drive.fileListFuntion(_ofFileId[1]["id"], widget._client);
      _length = _temp.length;
    } else {
      _temp = await drive.fileListFuntion(_ofFileId[2]["id"], widget._client);
      _length = _temp.length;
    }
    print(_temp.length);
    for (var j = 0; j < _temp.length; j++) {
      var temp1 = await drive.fileImageFuntion(_temp[j]["id"], widget._client);
      print(_temp[j]["name"]);
      temp1 = await temp1.stream.toBytes();
      //print(temp1);
      //_maybeimage.add(await temp1);
      someList.add(Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.memory(temp1, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        _temp[j]["name"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ));
    }
    // temp2 = await drive.fileImageFuntion(
    //     "1AX5bFVgJSmSBuPBLKJOReBLw6ZFe64JY", widget._client);
    // temp2 = temp2.stream.toBytes();
    // print(temp2);

    //_maybeimage = _temp;
    //print(_temp);
    //print(_length);

    // for (var j = 0; j < _length; j++) {
    //   var temp1 = await drive.fileImageFuntion(_temp[1]["id"], widget._client);
    //   temp1 = await temp1.stream.toBytes();
    //   //print(temp1);
    //   _maybeimage.add(await temp1);
    // }
    //print(_temp[1]); // prints the 2nd image link
    //_maybeimage = await drive.fileImageFuntion(_temp[1]["id"], widget._client);
    //print("in conversion");
    //_maybeimage = await _maybeimage.stream.toBytes();
    //print(_maybeimage);
  }
}
