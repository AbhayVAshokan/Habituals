import 'package:flutter/material.dart';

class Screen404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Oops!',
                    style: const TextStyle(
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '\n404: Page Not Found.\nWe can\'t seem to find the page you are looking for.\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RaisedButton(
                    color: const Color(0xFF4C7160),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Go Back Instead',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),

                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/404_asset.png',
                width: mediaQuery.size.width * 2 / 15,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
