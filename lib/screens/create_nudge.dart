// Screen where user can create his own nudges.

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
// import '../widgets/menu_dropdown.dart';
import '../widgets/my_bottom_navbar.dart';

class CreateNudge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
          // menuButton: true,
        ),
        body: Stack(
          children: [
            Center(
              child: Text('create nudge screen'),
            ),
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: MenuDropDown(),
            // ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
        ),
      ),
    );
  }
}
