import 'package:flutter/material.dart';

class WelcomeHeading extends StatelessWidget {
  final text;

  WelcomeHeading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    this.text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    ),
  );
}