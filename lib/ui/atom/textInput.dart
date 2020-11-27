import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {Key key,
      this.controller,
      this.placeholder,
      this.textStyle,
      this.borderStyle,
      this.activeBorderStyle,
      this.validator});

  final TextEditingController controller;
  final String placeholder;
  final TextStyle textStyle;
  final OutlineInputBorder borderStyle;
  final OutlineInputBorder activeBorderStyle;
  final Function validator;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      style: textStyle != null ? textStyle : TextStyle(color: Colors.black),
      decoration:
          InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              focusedBorder: activeBorderStyle,
              hintText: placeholder,
              enabledBorder: borderStyle,
              border: borderStyle,
            ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
