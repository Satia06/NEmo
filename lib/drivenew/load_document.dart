import 'package:flutter/material.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;
import 'dart:io' as io;
import 'dart:async';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:nemo/drivenew/googledrive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nemo/screens/list_of_entities.dart';
import 'package:nemo/screens/documentPage.dart';

import 'package:dart_vlc/dart_vlc.dart';

Future<void> loadDocument(List _ofFileId, var _client) async {
  final drive = GoogleDrive();
  someList.clear();
  traits.clear();
  medias.clear();
  final docsApi = docsV1.DocsApi(_client);
  var document = await docsApi.documents.get(_ofFileId[0]["id"]);
  //print('document.title: ${document.body}');
  title = document.title;
  description =
      document.body!.content![4].paragraph?.elements![0].textRun!.content;
  for (var i = 7; i < document.body!.content!.length; i++) {
    traits.add(
        document.body!.content![i].paragraph?.elements![0].textRun!.content);
  }

  print(traits.length);
  print("deletethis>" + traits[3]);
  traits.removeWhere((value) => value == "\n");
  print(traits.length);
  print(traits);
  var _imagefolder;
  var _videofolder;
  var _length;
  if (_ofFileId[1]["name"] == "images") {
    _imagefolder = await drive.fileListFuntion(_ofFileId[1]["id"], _client);
    _videofolder = await drive.fileListFuntion(_ofFileId[2]["id"], _client);
    _length = _imagefolder.length;
  } else {
    _imagefolder = await drive.fileListFuntion(_ofFileId[2]["id"], _client);
    _videofolder = await drive.fileListFuntion(_ofFileId[1]["id"], _client);
    _length = _imagefolder.length;
  }
  print(_imagefolder.length);
  for (var j = 0; j < _imagefolder.length; j++) {
    var temp1 = await drive.fileImageFuntion(_imagefolder[j]["id"], _client);
    print(_imagefolder[j]["name"]);
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      _imagefolder[j]["name"],
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
  //var temp2;
  final pathContext = path.Context(style: path.Style.windows);
  var tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  print(tempPath);
  //final currentPath = path.current;
  final filePath = pathContext.join(tempPath, _videofolder[0]["name"]);
  print(filePath);
  if (await io.File(filePath).exists() == false) {
    print("file not already there");
    await drive
        .fileImageFuntion(_videofolder[0]["id"], _client)
        .then((response) {
      print("file downloaded");
      Uint8List byteList;
      final bytesBuilder = BytesBuilder();
      (response).stream.listen((data) {
        print("stream thing");
        bytesBuilder.add(data);
      }).onDone(() async {
        byteList = await bytesBuilder.toBytes();
        final saveFile = await io.File(filePath);
        print("sfas");
        saveFile.writeAsBytes(byteList.toList());
        print("File saved at ${saveFile.path}");
      });
    });
  } else
    print("file already there");
  medias.add(
    Media.file(io.File(filePath.replaceAll('"', ''))),
  );
  // temp2 = temp2.stream.toBytes();
  // print(temp2);
  // final saveFile = io.File("E:");
  // print("gsdagdagdagdagadaddd");
  // var buffer = temp2 as List<int>;
  // saveFile.writeAsBytes(buffer);
  // print("File saved at ${saveFile.path}");
  //
  // _maybeimage = _temp;
  // print(_temp);
  // print(_length);
  //
  // for (var j = 0; j < _length; j++) {
  //   var temp1 = await drive.fileImageFuntion(_temp[1]["id"], widget._client);
  //   temp1 = await temp1.stream.toBytes();
  //   //print(temp1);
  //   _maybeimage.add(await temp1);
  // }
  // print(_temp[1]); // prints the 2nd image link
  // _maybeimage = await drive.fileImageFuntion(_temp[1]["id"], widget._client);
  // print("in conversion");
  // _maybeimage = await _maybeimage.stream.toBytes();
  // print(_maybeimage);
}
