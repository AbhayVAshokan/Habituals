import 'package:flutter/material.dart';
import 'package:habituals/widgets/my_bottom_navbar.dart';

import '../widgets/my_appbar.dart';

class InstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(context: context),
        body: SizedBox(
          width: mediaQuery.size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    const TextSpan(text: 'Before you can start,\n'),
                    const TextSpan(text: 'we need some numbers first.\n'),
                    const TextSpan(text: 'Your Well-Being Scores in the\n'),
                    const TextSpan(text: '5 Well-Being Dimensions!\n\n'),
                    const TextSpan(text: 'All you have to do,\n'),
                    const TextSpan(text: 'is rating 5x5 statements.'),
                  ],
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    letterSpacing: 0.4,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
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
                  width: isLandscape ? 400 : mediaQuery.size.width * 0.75,
                  child: Text(
                    'Easy! Let\'s do this.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: myBottomNavbar(context: context),
      ),
    );
  }
}
