import 'package:contact_list_demo/constants/strings.dart';
import 'package:contact_list_demo/ui/atom/generic_button.dart';
import 'package:contact_list_demo/ui/atom/text_input.dart';
import 'package:contact_list_demo/ui/page/menu_page.dart';
import 'package:contact_list_demo/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String status = NOT_LOGGED_IN_MESSAGE;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGenericInputRow(String type) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(type),
        ),
        SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: TextInput(
            key: Key('_emailKey'),
            controller: type == "Email" ? _emailController : _passwordController,
            placeholder: 'Enter $type',
            borderStyle: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0),
            ),
            activeBorderStyle: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0),
            ),
            validator: (value) {
              return type == "Email" ? EmailFormValidator.validate(value) : PasswordFormValidator.validate(value);
            },
          )
        )
      ],
    );
  }

  void onLoginPressed() async {
    var _email = _emailController.value.text;
    var _password = _passwordController.value.text;
    final emailErrorMessage = EmailFormValidator.validate(_email);
    final passwordEmailMessage =
        PasswordFormValidator.validate(_password);
    if (emailErrorMessage == null && passwordEmailMessage == null) {
      // Navigate to Home page after successful login

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(LOGIN_STATUS, true);
      await prefs.setString(USER_EMAIL, _email);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MenuPage(email: _email)),
          ModalRoute.withName("/Menu"));
    } else {
      /*
      show an message when email or password is 
      empty or invalid.
      */
      String errorText = '';
      if (emailErrorMessage != null) {
        errorText = emailErrorMessage;
      } else {
        errorText = passwordEmailMessage;
      }
      setState(() {
        status = errorText;
      });
    }
  }

  Widget buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: GenericButton(
        buttonText: "Login",
        onButtonPressed: onLoginPressed,
      ),
    );
  }

  Widget buildStatusText() {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(left: 20),
      child: SizedBox(
        height: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Status : ',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            Text(
              status,
              key: Key('_statusKey'),
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: [
            buildGenericInputRow("Email"),
            SizedBox(height: 15),
            buildGenericInputRow("Password"),
            buildLoginButton(),
            buildStatusText(),
          ],
        ),
      ),
    );
  }

}
