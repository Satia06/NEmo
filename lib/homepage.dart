import 'package:flutter/material.dart';
import 'package:nemo/Widgets/menubutton.dart';
import 'package:nemo/Widgets/searchbar.dart';
import 'dart:io';
import 'package:nemo/providers/search_provider.dart';
import 'package:nemo/Widgets/expansionSearchBar.dart';
import 'package:provider/provider.dart';
import 'package:nemo/screens/list_of_Entities.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void emptyFunction() {
    return;
  }

  void _close() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  child: Row(
                    children: [
                      MenuButton(
                          buttonName: 'File',
                          names: ['Print', 'Close'],
                          submenuFunctions: [emptyFunction, _close]),
                      MenuButton(
                          buttonName: 'Edit',
                          names: ['Add/Modify'],
                          submenuFunctions: [emptyFunction]),
                      MenuButton(
                          buttonName: 'View',
                          names: ['List'],
                          submenuFunctions: [emptyFunction]),
                      MenuButton(
                          buttonName: 'Help',
                          names: ['Feedback'],
                          submenuFunctions: [emptyFunction])
                    ],
                  ),
                ),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOfEntities()),
                        );
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
                    ChangeNotifierProvider(
                      create: (context) => SearchProvider(),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 > 600
                            ? 600
                            : MediaQuery.of(context).size.width / 2,
                        child: ExpansionSearchBar(tooltip: "Search here!"),
                        color: Colors.white.withOpacity(0.16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
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
    );
  }
}
