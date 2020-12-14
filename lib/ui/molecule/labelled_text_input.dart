import 'package:flutter/material.dart';
import '../atom/text_input.dart';

class LabelledTextInput extends StatelessWidget {
  LabelledTextInput(
      {Key key, this.labelText = '', this.inputController, this.inputValidator});

  final String labelText;
  final TextEditingController inputController;
  final dynamic inputValidator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(labelText),
        ),
        SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: TextInput(
            key: key,
            controller: inputController,
            placeholder: 'Enter $labelText',
            borderStyle: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0),
            ),
            activeBorderStyle: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0),
            ),
            validator: (value) {
              return inputValidator;
            },
          )
        )
      ],
    );
  }
}
