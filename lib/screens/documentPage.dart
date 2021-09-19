import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nemo/screens/video_player_custom.dart';
//E:\Coding\NEmo-main\rtyui
//////////
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nemo/drivenew/googledrive.dart';

final themeMode = ValueNotifier(2);

List<Media> medias = <Media>[];

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
  Player player = Player(id: 0);
  MediaType mediaType = MediaType.file;
  CurrentState current = new CurrentState();
  PositionState position = new PositionState();
  PlaybackState playback = new PlaybackState();
  GeneralState general = new GeneralState();
  VideoDimensions videoDimensions = new VideoDimensions(0, 0);
  List<Device> devices = <Device>[];
  TextEditingController controller = new TextEditingController();
  TextEditingController metasController = new TextEditingController();
  Media? metasMedia;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //  this.player = await Player.create(id: 0);
    this.player.currentStream.listen((current) {
      this.setState(() => this.current = current);
    });
    this.player.positionStream.listen((position) {
      this.setState(() => this.position = position);
    });
    this.player.playbackStream.listen((playback) {
      this.setState(() => this.playback = playback);
    });
  }

  final drive = GoogleDrive();
  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  @override
  void initState() {
    DartVLC.initialize();
    // TODO: implement initState
    super.initState();
    this.setState(() {
      this.player.open(
            new Playlist(medias: medias, playlistMode: PlaylistMode.single),
          );
    });
  }

  void dispose() {
    medias.clear();
  }

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
              // shrinkWrap: true,
              // controller: controller2,
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
                // FlatButton(
                //   child: Text('to video'),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => DartVLCExample()),
                //     );
                //   },
                // ),
                Container(
                  height: 290,
                  width: 820, //920
                  child: ListView(
                    controller: controller1,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(4.0),
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 2.0,
                            child: Video(
                              player: player,
                              width: 640,
                              height: 480,
                              volumeThumbColor: Colors.blue,
                              volumeActiveColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                          child: Text('Refresh Player'),
                          onPressed: () => this.setState(() {
                                this.player.open(
                                      new Playlist(
                                          medias: medias,
                                          playlistMode: PlaylistMode.single),
                                    );
                              }))
                    ],
                  ),
                ),
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
