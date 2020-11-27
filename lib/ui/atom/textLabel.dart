import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  TextLabel(
      {Key key, this.text = '', this.color, this.size = 14.0});

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
    );
  }
}
