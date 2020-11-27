import 'package:contact_list_demo/ui/atom/text_label.dart';
import 'package:flutter/material.dart';
import 'package:contact_list_demo/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_list_demo/ui/menu_page.dart';
import 'package:contact_list_demo/utils/validators.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showLoader = false;
  String status = NOT_LOGGED_IN_MESSAGE;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    // Fetch LOGIN_STATUS from shared preference.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool(LOGIN_STATUS);

    // If LOGIN_STATUS is not present in the shared preference then
    // create a new one and store it.
    if (loginStatus) {
      String userEmail = prefs.getString(USER_EMAIL);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MenuPage(email: userEmail)),
          ModalRoute.withName("/Menu"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: LoadingOverlay(
        isLoading: showLoader,
        opacity: 0.0,
        child: SafeArea(
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
                child: Column(children: [
                  headingText(),
                  detailsForm(),
                  loginButton(),
                  statusText()
                ]))),
      ),
    );
  }

  Widget headingText() {
    return (Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: 50.0,
          child: TextLabel(
            text: "Login Form",
            size: 20.0,
            color: Colors.black,
          ),
        )));
  }

  Widget detailsForm() {
    return (Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(children: [emailContainer(), passwordContainer()])));
  }

  Widget emailContainer() {
    return (SizedBox(
        height: 30,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Flexible(
            child: SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextLabel(
                    text: "Email",
                    size: 15.0,
                    color: Colors.black,
                  ),
                )),
          ),
          Flexible(
              flex: 2,
              child: Form(
                child: TextFormField(
                  key: Key('_emailKey'),
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    hintText: 'Enter Email',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return EmailFormValidator.validate(value);
                  },
                ),
              ))
        ])));
  }

  Widget passwordContainer() {
    return (Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SizedBox(
            height: 30,
            width: double.maxFinite,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Flexible(
                child: SizedBox(
                    width: 130,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextLabel(
                        text: "Password",
                        size: 15.0,
                        color: Colors.black,
                      ),
                    )),
              ),
              Flexible(
                  flex: 2,
                  child: Form(
                    child: TextFormField(
                        key: Key('_passwordKey'),
                        controller: _passwordController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1.0),
                          ),
                          hintText: 'Enter Password',
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          return EmailFormValidator.validate(value);
                        }),
                  ))
            ]))));
  }

  Widget loginButton() {
    return (Container(
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.all(8.0),
          onPressed: () async {
            var _email = _emailController.value.text;
            var _password = _passwordController.value.text;
            final emailErrorMessage = EmailFormValidator.validate(_email);
            final passwordEmailMessage =
                PasswordFormValidator.validate(_password);
            if (emailErrorMessage == null && passwordEmailMessage == null) {
              // setState(() {
              //   showLoader = true;
              // });
              // setState(() {
              //   showLoader = false;
              //   status = LOGGED_IN_MESSAGE;
              // });

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
          },
          child: TextLabel(text: "Login", size: 20.0),
        )));
  }

  Widget statusText() {
    return (Container(
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
            ))));
  }

  dispose() {
    super.dispose();
  }
}
