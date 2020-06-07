// Page not found screen: If the user navigates to a screen which is not defined/unreachable.

import 'package:flutter/material.dart';

import '../resources/constants.dart';

class Screen404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/logo_big.jpg',
                height: 75.0,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: const Text(
                            'Oops!',
                            style: const TextStyle(
                              fontSize: 100.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          '\n404: Page Not Found.\nWe can\'t seem to find the page you are looking for.\n',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RaisedButton(
                          color: color_primary,
                          onPressed: () {
                            if (Navigator.canPop(context))
                              Navigator.pop(context);
                            else
                              Navigator.pushNamed(context, '/home');
                          },
                          child: const Text(
                            'Go Back Instead',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/404_asset.png',
                    width: mediaQuery.size.width * 2 / 15,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
