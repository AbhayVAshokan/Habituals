import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/dob_picker.dart';
import './screens/login_screen.dart';
import './screens/body_queries.dart';
import './screens/mind_queries.dart';
import './screens/general_query.dart';
import './screens/splash_screen.dart';
import './screens/instruction_screen.dart';
import './screens/achievements_queries.dart';
import './screens/relationship_queries.dart';
import './screens/create_account_screen.dart';
import './screens/personal_growth_queries.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(HabitualApp());
}

class HabitualApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habituals',
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
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/dobPicker': (context) => DobPicker(),
        '/bodyQueries': (context) => BodyQueries(),
        '/mindQueries': (context) => MindQueries(),
        '/generalQuery': (context) => GeneralQuery(),
        '/instruction': (context) => InstructionScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
        '/achievementsQueries': (context) => AchievementsQueries(),
        '/relationshipQueries': (context) => RelationshipQueries(),
        '/personalGrowthQueries': (context) => PersonalGrowthQueries(),
      },
    );
  }
}
