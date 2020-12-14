import 'package:contact_list_demo/ui/molecule/app_bar_widget.dart';
import 'package:contact_list_demo/ui/organism/login_form.dart';
import 'package:flutter/material.dart';
import 'package:contact_list_demo/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'menu_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool showLoader = false;

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
      appBar: AppBarWidget(height: 50, text: LOGIN_HEADING),
      body: LoadingOverlay(
        isLoading: showLoader,
        opacity: 0.0,
        child: SafeArea(
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
                child: Column(children: [
                  detailsForm(),
                ]))),
      ),
    );
  }

  Widget detailsForm() {
    return LoginForm();
  }

  dispose() {
    super.dispose();
  }
}
