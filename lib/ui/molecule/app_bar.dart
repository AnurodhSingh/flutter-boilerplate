import 'package:contact_list_demo/ui/atom/app_bar_heading.dart';
import 'package:flutter/material.dart';
class AppBarWidget extends StatelessWidget {
  final text;

  AppBarWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
    title: AppBarHeading(text: text),
  );
}