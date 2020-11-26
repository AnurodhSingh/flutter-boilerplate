import 'package:contact_list_demo/constants/strings.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({  this.email });

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
                  onPressed: () {},
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
        )
      ),
    );
  }

}
