// Splash Screen: data of the user is fetched.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../resources/constants.dart';
import '../screens/login_screen.dart';
import '../screens/welcome_screen.dart';
import '../resources/realtime_data.dart';
import '../resources/local_storage.dart';
import '../screens/create_account_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  // Request storage permission.
  _permissionHandler() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.storage,
    ].request();
    print(status[Permission.storage]);
  }

  @override
  void initState() {
    super.initState();
    // Trigger transition animation
    Timer(
      Duration(milliseconds: 100),
      () {
        setState(() {
          _opacity = 1;
        });
      },
    );

    // Step 1: Request permissions
    _permissionHandler();

    // Step 2: Sync with server.
    getLocalPath().then((_) => syncWithServer());
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 750),
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
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo_big.jpg',
                        width: mediaQuery.size.width * 0.4,
                      ),
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
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Hero(
                          tag: 'signinButton',
                          child: RaisedButton(
                            elevation: 5.0,
                            color: color_accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FadeTransition(
                                  opacity: Tween(
                                    begin: 0.0,
                                    end: 1.0,
                                  ).animate(animation),
                                  child: isLoggedIn
                                      ? WelcomeScreen()
                                      : CreateAccountScreen(),
                                ),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 7.0,
                              ),
                              width: isLargeScreen
                                  ? 400
                                  : mediaQuery.size.width * 0.75,
                              child: Text(
                                isLoggedIn ? 'Continue' : 'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      !isLoggedIn
                          ? FittedBox(
                              child: Hero(
                                tag: 'already_have_an_account',
                                child: Row(
                                  children: [
                                    const Text(
                                      'Already have an account? ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              FadeTransition(
                                            opacity: Tween(
                                              begin: 0.0,
                                              end: 1.0,
                                            ).animate(animation),
                                            child: LoginScreen(),
                                          ),
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: const Text(
                                          'Log in',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
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
