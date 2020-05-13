// Instructing the user to answer the set of questions following the page.

import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  double _textOpacity = 0;
  double _buttonOpacity = 0;

  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 100),
      () {
        setState(() {
          _textOpacity = 1;
        });
        Timer(
          const Duration(seconds: 3),
          () {
            setState(() {
              _buttonOpacity = 1;
            });
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: SizedBox(
          width: mediaQuery.size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: _textOpacity,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(text: 'Before you can start,\n'),
                      const TextSpan(text: 'we need some numbers first.\n'),
                      const TextSpan(text: 'Your Well-Being Scores in the\n'),
                      const TextSpan(text: '5 Well-Being Dimensions!\n\n'),
                      const TextSpan(text: 'All you have to do,\n'),
                      const TextSpan(text: 'is rating 5x5 statements.'),
                    ],
                    style: TextStyle(
                      fontSize: isLargeScreen ? 28.0 : 20.0,
                      color: Colors.black,
                      letterSpacing: 0.4,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _buttonOpacity,
                child: RaisedButton(
                  elevation: 5.0,
                  color: Color(0xFFC6D7C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/generalQuery'),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                    ),
                    width: isLargeScreen ? 400 : mediaQuery.size.width * 0.75,
                    child: Text(
                      'Easy! Let\'s do this.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          nextScreen: '/generalQuery',
          backButton: false,
        ),
      ),
    );
  }
}
