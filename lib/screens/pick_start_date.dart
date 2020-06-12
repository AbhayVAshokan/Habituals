// Pick the start date for the journey of 66 days to track well being.

import 'dart:math';
import 'dart:async';

import 'package:intl/intl.dart';
import '../services/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:some_calendar/some_calendar.dart';

import './welcome_screen.dart';
import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';

class PickStartDate extends StatefulWidget {
  @override
  _PickStartDateState createState() => _PickStartDateState();
}

class _PickStartDateState extends State<PickStartDate> {
  // Function to display custom calendar
  showCalendar() {
    showCupertinoDialog(
      context: context,
      builder: (_) => SomeCalendar(
        primaryColor: Color(0xff5833A5),
        mode: SomeMode.Single,
        labels: new Labels(
          dialogDone: 'Select',
          dialogCancel: 'Cancel',
        ),
        isWithoutDialog: false,
        selectedDate: startingDate,
        scrollDirection: Axis.horizontal,
        startDate: DateTime.now().subtract(
          const Duration(days: 10000),
        ),
        lastDate: DateTime(
          DateTime.now().year + 1,
          (DateTime.now().add(const Duration(days: 10000)).month),
        ),
        done: (date) {
          setState(() {
            startingDate = date;
            Timer(
              const Duration(milliseconds: 500),
              () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                    child: WelcomeScreen(),
                  ),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  @override
  void initState() {
    querySubmission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: Center(
          child: SizedBox(
            width: min(700, mediaQuery.size.width * 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please pick your start date for your 66 days Well-Being-Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 30 : 20.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                FlatButton(
                  padding: const EdgeInsets.all(0.0),
                  splashColor: Colors.deepPurple[300],
                  color: Colors.deepPurple[100],
                  onPressed: showCalendar,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF8DAC9E),
                      ),
                    ),
                    child: Text(
                      DateFormat('dd-MM-yyyy').format(startingDate),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          nextScreen: '/welcome',
        ),
      ),
    );
  }
}
