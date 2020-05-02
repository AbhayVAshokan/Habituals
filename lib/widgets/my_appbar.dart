import 'package:flutter/material.dart';

AppBar myAppBar() {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset('assets/images/logo_small.jpg'),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ],
  );
}
