// Welcoming the user to todays nudges.

import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../services/api_calls.dart';
import '../resources/constants.dart';
import '../resources/realtime_data.dart';
import '../screens/well_being_audit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _welcomeOpacity = 0.0;
  double _firstLineOpacity = 0.0;
  double _secondLineOpacity = 0.0;
  double _containerOpacity = 0.0;

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;

    getNudges();

    Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _welcomeOpacity = 1;
        });
      },
    );

    Timer(
      const Duration(milliseconds: 2000),
      () {
        setState(() {
          _firstLineOpacity = 1;
        });
      },
    );

    Timer(
      const Duration(milliseconds: 3000),
      () {
        setState(() {
          _secondLineOpacity = 1;
        });
      },
    );

    Timer(
      const Duration(milliseconds: 4000),
      () {
        setState(() {
          _containerOpacity = 1;
        });
      },
    );
    getMemos();

    Timer(
      const Duration(
        seconds: 7,
        milliseconds: 500,
      ),
      () => Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FadeTransition(
            opacity: Tween(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: WellBeingAudit(),
          ),
          transitionDuration: const Duration(seconds: 1),
        ),
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    fabOffset = Offset(
      mediaQuery.size.width - 35,
      mediaQuery.size.height * 0.6,
    );

    int day = DateTime.now().difference(startingDate).inDays;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
        ),
        body: Container(
          width: mediaQuery.size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 500,
                ),
                opacity: _welcomeOpacity,
                curve: Curves.easeIn,
                child: Text(
                  'WELCOME!',
                  style: TextStyle(fontSize: isLargeScreen ? 70 : 50.0),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _firstLineOpacity,
                curve: Curves.easeIn,
                child: Text(
                  'Welcome to your Well-Being Journey',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25.0),
                ),
              ),
              const SizedBox(height: 30.0),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _secondLineOpacity,
                curve: Curves.easeIn,
                child: const Text(
                  'Happy Thrivingg!',
                  style: const TextStyle(fontSize: 25.0),
                ),
              ),
              const SizedBox(height: 50.0),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _containerOpacity,
                child: Container(
                  color: color_accent,
                  width: min(mediaQuery.size.width * 0.9, 600),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Motivation is what gets you started. Habit is what keeps you going',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 22 : 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Text('Jim Ryun'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
