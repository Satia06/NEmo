import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget{
  final String? tooltip;
  SearchBar({this.tooltip});

  @override
  Widget build(BuildContext context){
    return Container(
      //padding: EdgeInsets.fromLTRB(8,8,8,0)
      child: TextField(
        autocorrect: false,
        expands: false,
        decoration: InputDecoration(
          hintText: "Search Here!!",
          contentPadding: EdgeInsets.all(8.0),
          isDense: false,
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            splashRadius: 18,
            hoverColor: Colors.transparent,
            onPressed: (){},
            tooltip: "Search",
          ),
          //suffixIconConstraints: BoxConstraints.tight(Size.square(25.0)),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.vertical(top:Radius.circular(8.0),bottom: Radius.circular(4.0)),
           borderSide: BorderSide(color: Colors.black45)
         )
        ),
      )
    );
  }

}