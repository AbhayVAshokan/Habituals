import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habituals/screens/404_screen.dart';
import 'package:habituals/screens/loading_screen.dart';

import './screens/login_screen.dart';
import './screens/audit_screen.dart';
import './screens/body_queries.dart';
import './screens/mind_queries.dart';
import './screens/general_query.dart';
import './screens/splash_screen.dart';
import './screens/welcome_screen.dart';
import './screens/pick_start_date.dart';
import './screens/well_being_audit.dart';
import './screens/well_being_nudges.dart';
import './screens/instruction_screen.dart';
import './resources/screen_transition.dart';
import './screens/achievements_queries.dart';
import './screens/relationship_queries.dart';
import './screens/create_account_screen.dart';
import './screens/personal_growth_queries.dart';
import './screens/display_selection_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    HabitualApp(),
  );
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
        '/audit': (context) => AuditScreen(),
        '/loading': (context) => LoadingScreen(),
        '/nudges': (context) => WellBeingNudges(),
        '/instruction': (context) => InstructionScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
      },
      onUnknownRoute: (settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Screen404(),
      ),
      onGenerateRoute: (settings) {
        Route page;
        switch (settings.name) {
          case "/generalQuery":
            page = ScreenSlideTransition(screen: GeneralQuery());
            break;
          case "/bodyQueries":
            page = ScreenSlideTransition(screen: BodyQueries());
            break;
          case "/mindQueries":
            page = ScreenSlideTransition(screen: MindQueries());
            break;
          case "/relationshipQueries":
            page = ScreenSlideTransition(screen: RelationshipQueries());
            break;
          case "/personalGrowthQueries":
            page = ScreenSlideTransition(screen: PersonalGrowthQueries());
            break;
          case "/achievementsQueries":
            page = ScreenSlideTransition(screen: AchievementsQueries());
            break;
          case "/pickStartDate":
            page = ScreenSlideTransition(screen: PickStartDate());
            break;
          case "/welcome":
            page = ScreenSlideTransition(screen: WelcomeScreen());
            break;
          case "/home":
            page = ScreenSlideTransition(screen: WellBeingAudit());
            break;
          case "/displaySelection":
            page = ScreenSlideTransition(screen: DisplaySelectionScreen());
            break;
        }

        return page;
      },
    );
  }
}
