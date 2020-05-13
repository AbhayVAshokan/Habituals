// Placeholder screen (loading screen) while the API is fetching the content.

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/loading_background.jpg',
                height: mediaQuery.size.width,
                width: mediaQuery.size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: mediaQuery.size.width / 3,
                left: isLargeScreen
                    ? mediaQuery.size.width / 2 - 300
                    : mediaQuery.size.width * 0.125,
                child: SizedBox(
                  width: isLargeScreen ? 600 : mediaQuery.size.width * 0.75,
                  child: LinearProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
