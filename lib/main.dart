import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemo/homepage.dart';
import 'package:desktop_window/desktop_window.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nemo/screens/signinpage.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:nemo/screens/video_player_custom.dart';
import 'dart:async';
import 'dart:io';
import 'package:dart_vlc_ffi/src/internal/dynamiclibrary.dart';
//import 'package:ffi-patch'
//import 'package:dart_vlc_ffi/dart_vlc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartVLC.initialize();
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await DesktopWindow.setMinWindowSize(Size(600, 800));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nemo',
        theme: ThemeData.dark(),
        home: LoginPage()); //DartVLCExample() /*DartVLCExample()*/);
  }
}

//C:\Users\ritesh\AppData\Local\Temp\group of horse running in field.mp4
//(package:dart_vlc_ffi/src/internal/dynamiclibrary.dart)

// ThemeData(
// fontFamily: 'Montserrat',
// primaryTextTheme: TextTheme(
// button: TextStyle(
// color: Colors.white,
// ),
// headline4: TextStyle(color: Colors.white70, fontSize: 17)),
// )
