// Splash Screen: data of the user is fetched.

import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 100),
      () {
        setState(() {
          _opacity = 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          opacity: _opacity,
          child: SizedBox(
            width: mediaQuery.size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo_big.jpg',
                      width: mediaQuery.size.width * 0.4,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 35.0,
                        child: Text(
                          'YOUR CORPORATE',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Text(
                        'WELL-BEING',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'COMPANION',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Color(0xFFC6D7C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/createAccount'),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                            ),
                            width: isLargeScreen
                                ? 400
                                : mediaQuery.size.width * 0.75,
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/login'),
                              child: const Text(
                                'Log in',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
