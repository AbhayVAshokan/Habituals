// File specifying all the different screens, transition and theme data.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/404_screen.dart';
import './resources/constants.dart';
import './screens/create_nudge.dart';
import './screens/login_screen.dart';
import './screens/memos_screen.dart';
import './screens/audit_screen.dart';
import './screens/body_queries.dart';
import './screens/mind_queries.dart';
import './screens/general_query.dart';
import './screens/splash_screen.dart';
import './screens/loading_screen.dart';
import './screens/nudge_expanded.dart';
import './screens/welcome_screen.dart';
import './screens/pick_start_date.dart';
import './screens/well_being_wall.dart';
import './screens/well_being_audit.dart';
import './screens/well_being_nudges.dart';
import './screens/instruction_screen.dart';
import './screens/well_being_journey.dart';
import './resources/screen_transition.dart';
import './screens/achievements_queries.dart';
import './screens/relationship_queries.dart';
import './screens/create_account_screen.dart';
import './screens/well_being_pulse_check.dart';
import './screens/personal_growth_queries.dart';
import './screens/display_selection_screen.dart';

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
        primaryColor: color_primary,
        accentColor: color_accent,
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          headline4: TextStyle(
            color: color_primary,
            fontWeight: FontWeight.w600,
            fontSize: 30.0,
          ),
        ),
        unselectedWidgetColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/loading': (context) => LoadingScreen(),
        '/createAccount': (context) => CreateAccountScreen(),
      },
      onUnknownRoute: (settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Screen404(),
      ),
      onGenerateRoute: (settings) {
        Route page;
        switch (settings.name) {
          case "/home":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: WellBeingAudit(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/instruction":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: InstructionScreen(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/memos":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: MemosScreen(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/pulseCheck":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: WellBeingPulseCheck(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/audit":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: AuditScreen(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/nudges":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: WellBeingNudges(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/nudgeExpanded":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: NudgeExpanded(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/journey":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: WellBeingJourney(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
          case "/wall":
            page = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: WellBeingWall(),
              ),
              transitionDuration: const Duration(milliseconds: 250),
            );
            break;
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
          case "/createNudge":
            page = ScreenSlideTransition(screen: CreateNudge());
            break;
          case '/displaySelection':
            page = ScreenSlideTransition(screen: DisplaySelectionScreen());
        }
        return page;
      },
    );
  }
}
