import 'package:flutter/material.dart';

Widget myBottomNavbar({@required BuildContext context}) {
  return Container(
    height: 60.0,
    alignment: Alignment.topLeft,
    child: IconButton(
      padding: const EdgeInsets.all(5.0),
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 28.0,
      ),
    ),
  );
}
