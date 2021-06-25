import 'package:flutter/material.dart';
import 'package:nemo/Widgets/menubutton.dart';
import 'package:nemo/Widgets/searchbar.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 150,
            width: double.infinity,
            child: Row(
              children: [
                  MenuButton(buttonName: 'File',names: ['Print', 'Close']),
                  MenuButton(buttonName: 'Edit',names: ['Add/Modify']),
                  MenuButton(buttonName: 'View',names: ['List']),
                  MenuButton(buttonName: 'Help',names: ['Feedback'] )
              ],
            ),
          ),
          Column(
            children: [
              OutlinedButton(
                onPressed: (){},
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
              Container(
                width: MediaQuery.of(context).size.width/2 >600?600: MediaQuery.of(context).size.width/2,
                child: SearchBar(tooltip:"Search Here!!"),
              ),
              SizedBox(height: 15,)
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          )
        ],
        ),
      )
    );
  }
}

