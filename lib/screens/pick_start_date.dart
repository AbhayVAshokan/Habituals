// Pick the start date for the journey of 66 days to track well being.

import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';

class PickStartDate extends StatefulWidget {
  @override
  _PickStartDateState createState() => _PickStartDateState();
}

class _PickStartDateState extends State<PickStartDate> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
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
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          doneStyle: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: isLargeScreen ? 22.0 : 18.0,
                          ),
                          itemStyle:
                              TextStyle(fontSize: isLargeScreen ? 22.0 : 18.0),
                          cancelStyle: TextStyle(
                            fontSize: isLargeScreen ? 22.0 : 18.0,
                            color: Colors.red
                          ),
                        ),
                        showTitleActions: true,
                        minTime: DateTime.now().subtract(
                          const Duration(
                            days: 365,
                          ),
                        ),
                        maxTime: DateTime.now().add(
                          const Duration(
                            days: 365,
                          ),
                        ), onConfirm: (date) {
                      setState(() {
                        startingDate = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
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
        bottomNavigationBar:
            myBottomNavbar(context: context, nextScreen: '/welcome'),
      ),
    );
  }
}
