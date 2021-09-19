// import 'dart:io' as io;
// import 'package:dart_vlc/dart_vlc.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:nemo/drive/driveapi.dart';
//
// class VideoPlayer extends StatefulWidget{
//   final int? playerId;
//   final String? videoName;
//   VideoPlayer({Key? key, required this.playerId, required this.videoName}) : super(key: key);
//
//   @override
//   VideoPlayerState createState() => VideoPlayerState();
// }
//
// class VideoPlayerState extends State<VideoPlayer> {
//   Player? player;
//   MediaType mediaType = MediaType.file;
//   CurrentState current = CurrentState();
//   PositionState position = PositionState();
//   PlaybackState playback = PlaybackState();
//   GeneralState general = GeneralState();
//   List<Media> medias = <Media>[];
//   List<Device> devices = <Device>[];
//   TextEditingController controller = TextEditingController();
//   TextEditingController metasController = TextEditingController();
//   Media? metasMedia;
//
//   Media? media0;
//
//   final pathContext = path.Context(style: path.Style.windows);
//   final currentPath = path.current;
//
//   void init() async {
//     player = Player(
//       id: widget.playerId!,
//       videoWidth: 480,
//       videoHeight: 360,
//     );
//     final videoPath = pathContext.join(currentPath, widget.videoName?? "NOTHING");
//     print(byteList);
//     Media.file(
//         byteList.toList()
//     );
//
//       // Media.fromMap(
//       //     byteList.toList()
//       // ).then((value) {
//       //   media0 = value;
//       //   player?.open(
//       //     media0!,
//       //     autoStart: false
//       //   );
//       // });
//
//     // else {
//     //   print("Video does not exist!!");
//     //   Media.file(
//     //     io.File('C:/Users/Sample.mp4')
//     //   ).then((value){
//     //     media0 = value;
//     //     player?.open(
//     //       media0!,
//     //       autoStart: false
//     //     );
//     //   });
//     // }
//     // Media.network(url)
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//     if(this.mounted){
//       this.player?.currentStream.listen((current) {
//         this.setState(() => this.current = current);
//       });
//       this.player?.positionStream.listen((position) {
//         this.setState(() => this.position = position);
//       });
//       this.player?.playbackStream.listen((playback) {
//         this.setState(() => this.playback = playback);
//       });
//       this.player?.generateStream.listen((general) {
//         this.setState(() => this.general = general);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     player?.stop();
//     player?.dispose();
//   }
//
//   // @override
//   // Future<void> didChangeDependencies() async {
//   //   super.didChangeDependencies();
//   //   this.devices = await Devices.all;
//   //   Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
//   //   equalizer.setPreAmp(10.0);
//   //   equalizer.setBandAmp(31.25, 10.0);
//   //   player.setEqualizer(equalizer);
//   //   this.setState(() {});
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Video(
//       playerId: widget.playerId!,
//       height: 360.0,
//       width: 480.0,
//       scale: 1.0,
//       showControls: true,
//     );
//   }
//
// }
