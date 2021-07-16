import 'package:flutter/material.dart';
import 'dart:math';

class MenuButton extends StatelessWidget {
  final String buttonName;
  final List<String> names;
  final List<void Function()> submenuFunctions;

  MenuButton(
      {required this.buttonName,
      required this.names,
      required this.submenuFunctions});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: PopupMenuButton(
        offset: Offset.fromDirection(pi / 2, 30.0),
        elevation: 2.0,
        color: Colors.black.withOpacity(0.16),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            buttonName,
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
        itemBuilder: (context) {
          //return a list
          return List.generate(
              names.length,
              (index) => PopUp(
                    child: TextButton(
                      onPressed: submenuFunctions[index],
                      child: Text(
                        names[index],
                        style: Theme.of(context).primaryTextTheme.button,
                      ),
                    ),
                    height: 25.0,
                  ));
        },
      ),
    );
  }
}

class PopUp<T> extends PopupMenuEntry<T> {
  @override
  final double height;
  final Widget child;
  @override
  bool represents(T? value) {
    return true;
  }

  PopUp({Key? key, required this.height, required this.child})
      : super(key: key);
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
