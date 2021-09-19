import 'package:nemo/drivenew/googledrive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nemo/homepage.dart';
import 'package:nemo/getsearchlist.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final drive = GoogleDrive();
  bool _load = false;
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
          Container(
            //color: Colors.grey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text(
                    'Log in using your Google account having the access to said drive',
                    // style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      setState(() {
                        _load = true;
                      });
                      var _client = await drive.getHttpClient();
                      var _list;
                      _list = await drive.fileListFuntion(
                          '1bHsgD1OSCNk9CWHhLBOsTEyIel3qwSqb', _client);
                      await getsearchitems(_client);
                      print("completed with search database");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(_client, _list)),
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ),
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
