import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:nemo/providers/search_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final String? tooltip;
  final Function(String)? onSubmittedCall;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  SearchBar(
      {this.tooltip, this.onSubmittedCall, this.controller, this.focusNode});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: false,
      expands: false,
      onChanged: (text) {
        if (searchProvider.isExpanded! == false)
          searchProvider.isExpanded = true;
      },
      onSubmitted: (text) {
        //TODO: Not detected
        //widget.onsubmittedCall!(widget.controller!.text);
        if (widget.focusNode?.hasFocus == true) {
          widget.focusNode?.unfocus();
        }
        searchProvider.isExpanded = false;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.tooltip ?? "",
        contentPadding: EdgeInsets.all(8.0),
        isDense: false,
        //suffixIcon: IconButton(
        // suffixIcon: IconButton(
        //    icon: Icon(Icons.search),
        //    splashRadius: 18,
        //  hoverColor: Colors.transparent,
        //  onPressed: (){},
        //  tooltip: "Search",
        //  color: Colors.white,
        //),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
