import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final buttonText;
  final Function onButtonPressed;

  GenericButton({ Key key, this.buttonText, this.onButtonPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) => FlatButton(
    color: Colors.blue,
    child: Text(
      this.buttonText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    ),
    onPressed: () => onButtonPressed(),
  );
}