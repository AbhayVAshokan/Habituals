// Set of API calls.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/keys.dart';
import '../resources/dummy_data.dart';
import '../resources/realtime_data.dart';
import '../models/nudge_chart_7days.dart';

// Register a new user into the database.
Future registerUser({
  @required String password,
  @required DateTime createdAt,
  @required String emailAddress,
  int age,
  String gender,
  String position,
  bool mailingList,
}) async {
  try {
    ////////////////////////////// Add code here
    Future function() => null;
    var result = await function();
    result.toString();
    signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    currentUser = dummyUser;
    return true;
    ////////////////////////////// Add code here
  } catch (e) {
    ////////////////////////////// Update errors

    // Network failure
    if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED') ||
        e.toString().contains('auth/network-request-failed'))
      Fluttertoast.showToast(
        msg: "Network error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    // Email already registered
    else if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE') ||
        e.toString().contains('auth/email-already-in-use'))
      Fluttertoast.showToast(
        msg: "Email already registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    else
      print(e.toString());
    ////////////////////////////// Update errors
    return null;
  }
}

// Login
Future signInWithEmailAndPassword(
    {@required String email, @required String password}) async {
  try {
    print(email);
    print(password);
    print(baseUrl + ':' + port + '/user/login');
    var response = await http.post(
      Uri.encodeFull(baseUrl + ':' + port + '/user/login'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response);
    print('hello world');
    return response;
  } catch (e) {
    ////////////////////////////// Update errors

    // User not registered
    if (e.toString().contains('ERROR_USER_NOT_FOUND') ||
        e.toString().contains('auth/user-not-found'))
      Fluttertoast.showToast(
        msg: "User not registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    // Network failure
    else if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED') ||
        e.toString().contains('auth/network-request-failed'))
      Fluttertoast.showToast(
        msg: "Network error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    // Wrong password entered.
    else if (e.toString().contains('ERROR_WRONG_PASSWORD') ||
        e.toString().contains('auth/wrong-password'))
      Fluttertoast.showToast(
        msg: "Wrong password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    else
      print(e.toString());
    ////////////////////////////// Update errors
    return null;
  }
}

// Get Nudges for the given user
getNudges({@required String emailAddress}) {
  bodyNudges = dummyBodyNudges;
  mindNudges = dummyMindNudges;
  relationshipNudges = dummyRelationshipNudges;
  achievementNudges = dummyAchievementNudges;
  personalGrowthNudges = dummyPersonalGrowthNudges;
  allNudges = [
    ...bodyNudges,
    ...mindNudges,
    ...relationshipNudges,
    ...achievementNudges,
    ...personalGrowthNudges,
  ];

  // Sorting Nudges according to their dates.
  bodyNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
  mindNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
  achievementNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
  relationshipNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
  personalGrowthNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
  allNudges.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);

  allNudgesToday = allNudges
      .where((nudge) => nudge.date.difference(DateTime.now()).inDays == 0)
      .toList();
  allNudges7Days = allNudges
      .where(
        (nudge) => (nudge.date.isAfter(
              DateTime.now().subtract(
                const Duration(days: 7),
              ),
            ) &&
            nudge.date.isBefore(
              DateTime.now(),
            )),
      )
      .toList();
  allNudges66Days = allNudges66Days;
  lineChart7Days = dummyLineChart7Days;

  barChart7DaysCompleted = dummyBarChart7Days
      .where((NudgeBarChart bar) => bar.status == 'completed')
      .toList();
  barChart7DaysNotCompleted = dummyBarChart7Days
      .where((NudgeBarChart bar) => bar.status == 'not completed')
      .toList();
  barChart7DaysSkipped = dummyBarChart7Days
      .where((NudgeBarChart bar) => bar.status == 'sipped')
      .toList();

  lineGraph66DaysCompleted =
      dummyLineChart66Days.where((line) => line.status == 'completed').toList();
  lineGraph66DaysNotCompleted = dummyLineChart66Days
      .where((line) => line.status == 'not completed')
      .toList();
  lineGraph66DaysSkipped =
      dummyLineChart66Days.where((line) => line.status == 'skipped').toList();
  lineWellBeing66Days = dummyNudgeWellBeingGraph;
}

getMemos() {
  memos = dummyMemos;
}
