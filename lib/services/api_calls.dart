// Set of API calls.

import 'dart:convert';

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
  @required String emailAddress,
  String age,
  String gender,
  String position,
  bool mailingList,
}) async {
  try {
    http.Response response = await http.post(
      Uri.encodeFull(baseUrl + ':' + port + '/user/register'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'emailAddress': emailAddress,
        'password': password,
        'gender': gender,
        'age': age,
        'position': position,
        'mailingList': mailingList.toString(),
      },
    );

    Map jsonResponse = json.decode(response.body);

    if (jsonResponse['status']) return response;

    Fluttertoast.showToast(
      msg: jsonResponse['error'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  } catch (e) {
    if (e.toString().contains('Network is unreachable'))
      Fluttertoast.showToast(
        msg: 'No network connectivity',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  }
}

// Login
Future signInWithEmailAndPassword(
    {@required String email, @required String password}) async {
  try {
    http.Response response = await http.post(
      Uri.encodeFull(baseUrl + ':' + port + '/user/login'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'emailAddress': email,
        'password': password,
      },
    );

    Map jsonResponse = json.decode(response.body);

    if (jsonResponse['status']) return response;

    Fluttertoast.showToast(
      msg: jsonResponse['error'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  } catch (e) {
    if (e.toString().contains('Network is unreachable'))
      Fluttertoast.showToast(
        msg: 'No network connectivity',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  }
}

// Submit initial set of questions
Future querySubmission() async {
  try {
    http.Response response = await http.post(
      Uri.encodeFull(baseUrl + ':' + port + '/user/questions'),
      headers: {
        'Accept': 'application/json',
        'Authorization':
            "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEFkZHJlc3MiOiJhYmhheXZhc2hva2FuQGdtYWlsLmNvbSIsInVzZXJJZCI6ImZlZTEyYmMyLTRmYzItNDFjMi05ZTRiLTkwMTQ1ZDFhMjYzNSIsImlhdCI6MTU5MTgwOTE0Mn0.p_fO5PtC6pizBufvL5JrD1r8Pyl41vq9aQBgRZE2VYw",
      },
      body: {
        'generalQuery': generalQuery.toString(),
        'startDate': startingDate.toIso8601String(),
        'bodyQuery': {
          '1': bodyQueries[0],
          '2': bodyQueries[1],
          '3': bodyQueries[2],
          '4': bodyQueries[3],
          '5': bodyQueries[4]
        }.toString(),
        'mindQuery': {
          '1': mindQueries[0],
          '2': mindQueries[1],
          '3': mindQueries[2],
          '4': mindQueries[3],
          '5': mindQueries[4],
        }.toString(),
        'relationshipQuery': {
          '1': relationshipQueries[0],
          '2': relationshipQueries[1],
          '3': relationshipQueries[2],
          '4': relationshipQueries[3],
          '5': relationshipQueries[4],
        }.toString(),
        'achievementQuery': {
          '1': achievementsQueries[0],
          '2': achievementsQueries[1],
          '3': achievementsQueries[2],
          '4': achievementsQueries[3],
          '5': achievementsQueries[4],
        }.toString(),
        'personalDevelopmentQuery': {
          '1': personalGrowthQueries[0],
          '2': personalGrowthQueries[1],
          '3': personalGrowthQueries[2],
          '4': personalGrowthQueries[3],
          '5': personalGrowthQueries[4],
        }.toString(),
      },
    );

    print(response.body);
    Map jsonResponse = json.decode(response.body);

    if (jsonResponse['status']) return response;

    Fluttertoast.showToast(
      msg: jsonResponse['error'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  } catch (e) {
    if (e.toString().contains('Network is unreachable'))
      Fluttertoast.showToast(
        msg: 'No network connectivity',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
