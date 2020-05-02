import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: mediaQuery.size.width,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/logo_big.jpg',
                    width: mediaQuery.size.width * 0.4,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'YOUR CORPORATE',
                      style: Theme.of(context).textTheme.headline4,
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
                        onPressed: () => Navigator.pushNamed(
                            context, '/createAccount'),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 7.0,
                          ),
                          width: mediaQuery.size.width * 0.75,
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
                            onTap: () => Navigator.pushNamed(context, '/login'),
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
    );
  }
}
