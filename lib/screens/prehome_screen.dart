import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';

class PreHomeScreen extends StatefulWidget {
  @override
  _PreHomeScreenState createState() => _PreHomeScreenState();
}

class _PreHomeScreenState extends State<PreHomeScreen> {
  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(() {});
          },
        ),
        body: Stack(
          children: [
            Container(
              width: mediaQuery.size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'WELCOME!',
                    style: const TextStyle(fontSize: 50.0),
                  ),
                  const Text(
                    'This is the first day of your Well-Being Journey.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25.0),
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Happy Thrivingg!',
                    style: const TextStyle(fontSize: 25.0),
                  ),
                  const SizedBox(height: 50.0),
                  Container(
                    color: Color(0xFFC6D7C3),
                    width: min(mediaQuery.size.width * 0.9, 600),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 15.0,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Motivation is what gets you started. Habit is what keeps you going',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Text('Jim Ryun'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BackdropFilter(
              filter: menuBarHeight > 0 && !isLandscape
                  ? ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    )
                  : ImageFilter.blur(),
              child: Container(
                height: mediaQuery.size.height,
                width: mediaQuery.size.width,
                color: Colors.black.withOpacity(0),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: MenuDropDown(),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          nextScreen: '/home',
        ),
      ),
    );
  }
}
