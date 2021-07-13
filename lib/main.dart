import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemo/homepage.dart';
import 'package:desktop_window/desktop_window.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryTextTheme: TextTheme(
              button: TextStyle(
                color: Colors.white,
              ),
              headline4: TextStyle(color: Colors.white70, fontSize: 17)),
        ),
        home: HomePage());
  }
}
