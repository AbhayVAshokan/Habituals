// Memos screen.

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class YourMemos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
        ),
        body: Center(
          child: Text('your memos'),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
        ),
      ),
    );
  }
}
