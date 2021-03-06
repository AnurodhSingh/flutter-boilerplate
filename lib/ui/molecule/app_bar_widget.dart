import 'package:contact_list_demo/ui/atom/app_bar_heading.dart';
import 'package:flutter/material.dart';
class AppBarWidget  extends StatelessWidget implements PreferredSizeWidget {
  final text;
  final double height;
  AppBarWidget({Key key, this.text, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
    title: AppBarHeading(text: text),
  );

  @override
  Size get preferredSize => Size.fromHeight(height);
}