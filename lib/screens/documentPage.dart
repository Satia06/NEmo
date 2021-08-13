import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;
import 'package:googleapis/drive/v2.dart';
//import 'package:kt_dart/collection.dart';
//import 'package:kt_dart/kt.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nemo/drivenew/googledrive.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'dart:html' as html;
//import 'package:video_player_web/video_player_web.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';

final themeMode = ValueNotifier(2);

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class DocumentPage extends StatefulWidget {
  List _traits = [];
  var _description;
  var _maybeimage;
  String _title;
  DocumentPage(this._description, this._traits, this._title, this._maybeimage);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  // VideoPlayerController _controller = VideoPlayerController.network(
  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
  someFunction() async {
    // final blob = await html.Blob(widget._temp);
    // final url = await html.Url.createObjectUrlFromBlob(blob);
    // _controller = await VideoPlayerController.network(url);
  }

  final drive = GoogleDrive();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   child: FlatButton(
                  //       onPressed: () {
                  //         //_loadDocument();
                  //       },
                  //       child: Text('Click to refresh')),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Description:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Text(widget._description),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index1) {
                        var item = widget._traits[index1]; //_list[index];
                        return ListTile(
                          leading: MyBullet(),
                          title: Text(item),
                        );
                      },

                      itemCount: widget._traits.length, //_list.length,
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 10,
              height: double.infinity,
              color: Colors.black,
              child: Text(""),
            ),
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Container(
                      color: Colors.black38,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          //scrollDirection: Axis.vertical,
                          enlargeCenterPage: true,
                        ),
                        items: widget._maybeimage,
                      ),
                    )),
                Text("Photos"),
                // Center(
                //   child: _controller.value.isInitialized
                //       ? AspectRatio(
                //           aspectRatio: _controller.value.aspectRatio,
                //           child: VideoPlayer(_controller),
                //         )
                //       : Container(),
                // )
                // Container(
                //   height: 50,
                //   child: Image.memory(widget._maybeimage),
                //),
                //Media(widget._maybeimage.stream, widget._maybeimage.length),
                //Image(image: _maybeimage)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

/////////////////////////////////////////////
// ListView.builder(
// itemCount: imgList.length,
// itemBuilder: (context, index) {
// return Container(
// child:
// Image.network(imgList[index], fit: BoxFit.cover),
// );
// },
// ),
//////////////////////////
// Future<void> _loadDocument() async {
//   final docsApi = docsV1.DocsApi(widget._client);
//   var document = await docsApi.documents.get(widget.fileId);
//   print('document.title: ${document.body}');
//   _description =
//       document.body!.content![4].paragraph?.elements![0].textRun!.content;
//   for (var i = 7; i < document.body!.content!.length; i++) {
//     _traits.add(
//         document.body!.content![i].paragraph?.elements![0].textRun!.content);
//   }
//   print(_traits);
//   _maybeimage = await drive.fileImageFuntion(widget._client);
// }
