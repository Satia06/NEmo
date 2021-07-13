import 'package:flutter/material.dart';

class ListOfEntities extends StatefulWidget {
  ListOfEntities({Key? key}) : super(key: key);

  @override
  _ListOfEntitiesState createState() => _ListOfEntitiesState();
}

class _ListOfEntitiesState extends State<ListOfEntities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
            height: double.infinity,
            color: Colors.grey,
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
                )
              ],
            )),
        Container(
          height: double.infinity,
          color: Colors.green,
          width: MediaQuery.of(context).size.width * 2 / 3,
        ),
      ],
    ));
  }
}
