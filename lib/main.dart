import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/create_account_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(HabitualApp());
}

class HabitualApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitual',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Color(0xFF8DAC9D),
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        unselectedWidgetColor: Colors.black,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
      },
    );
  }
}
