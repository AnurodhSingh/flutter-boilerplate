import 'package:contact_list_demo/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.title, this.email});

  final String title;
  final String email;
  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                WELCOME_MESSAGE,
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  onLogout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void onLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGIN_STATUS, false);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        ModalRoute.withName("/Home"));
  }
}
