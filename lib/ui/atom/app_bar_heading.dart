import 'package:flutter/material.dart';

class AppBarHeading extends StatelessWidget {
  final text;

  AppBarHeading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    this.text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold
    ),
  );
}