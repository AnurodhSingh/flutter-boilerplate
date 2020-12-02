import 'package:contact_list_demo/constants/strings.dart';
import 'package:contact_list_demo/ui/atom/generic_button.dart';
import 'package:contact_list_demo/ui/atom/text_label.dart';
import 'package:contact_list_demo/ui/atom/welcome_heading.dart';
import 'package:contact_list_demo/ui/molecule/app_bar_widget.dart';
import 'package:contact_list_demo/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      appBar: AppBarWidget(height: 50, text: MENU_HEADING),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WelcomeHeading(text: WELCOME_MESSAGE),
              TextLabel(
                text: widget.email,
                size: 25,
              ),
              GenericButton(
                buttonText: "Logout",
                onButtonPressed: onLogout,
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
