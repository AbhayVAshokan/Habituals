// Set of API calls.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';
import '../models/nudge.dart';
import '../resources/keys.dart';
import '../resources/dummy_data.dart';
import '../resources/local_storage.dart';
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
    // Step 1: Register user into the server
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

    final Map jsonResponse = json.decode(response.body);

    // Step 2: Login the user to get the auth token.
    if (jsonResponse['status']) {
      http.Response loginResponse = await http.post(
        Uri.encodeFull(baseUrl + ':' + port + '/user/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'emailAddress': emailAddress,
          'password': password,
        },
      );

      authToken = json.decode(loginResponse.body)['authToken'];

      // Step 3: updating realtime data
      currentUser = User(
        emailAddress: emailAddress,
        age: int.parse(age),
        gender: gender,
        mailingList: mailingList,
        position: position,
      );

      // Function to calculate average
      double avg(arr) {
        double sum = 0;
        arr.forEach((element) => sum += element);
        return sum / arr.length;
      }

      bodyAverage = avg(bodyQueries);
      mindAverage = avg(mindQueries);
      achievementAverage = avg(achievementsQueries);
      relationshipAverage = avg(relationshipQueries);
      personalDevelopmentAverage = avg(personalGrowthQueries);

      // Step 2: Update local data
      writeToFile(
        content: {
          'emailAddress': currentUser.emailAddress,
          'age': currentUser.age,
          'gender': currentUser.gender,
          'mailingList': currentUser.mailingList,
          'position': currentUser.position,
          'auth': authToken,
          'startingDate': startingDate.toString(),
          'generalQuery': generalQuery,
          'body': bodyAverage,
          'mind': mindAverage,
          'achievement': achievementAverage,
          'relationship': relationshipAverage,
          'personalDevelopment': personalDevelopmentAverage,
        },
      );

      return response;
    }

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

    if (jsonResponse['status']) {
      authToken = jsonResponse['authToken'];

      http.Response response = await http.get(
        Uri.encodeFull(baseUrl + ':' + port + '/user/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': authToken,
        },
      );

      // Step 1: updating realtime data
      Map profileResponse = json.decode(response.body);
      currentUser = User(
        emailAddress: profileResponse['emailAddress'],
        age: profileResponse['age'],
        gender: profileResponse['gender'],
        mailingList: profileResponse['mailingList'] == 'subscribed',
        position: profileResponse['position'],
      );

      startingDate = DateTime.parse(profileResponse['startDate']);

      // generalQuery = double.parse(profileResponse['generalQuery'].toString());

      // bodyAverage = double.parse(profileResponse['bodyQuery'].toString());
      // mindAverage = double.parse(profileResponse['mindQuery'].toString());
      // achievementAverage =
      //     double.parse(profileResponse['achievementQuery'].toString());
      // relationshipAverage =
      //     double.parse(profileResponse['relationshipQuery'].toString());
      // personalDevelopmentAverage =
      //     double.parse(profileResponse['personalDevelopmentQuery'].toString());

      // Step 2: Update local data
      writeToFile(
        content: {
          'emailAddress': currentUser.emailAddress,
          'age': currentUser.age,
          'gender': currentUser.gender,
          'mailingList': currentUser.mailingList,
          'position': currentUser.position,
          'auth': authToken,
          'startingDate': startingDate.toString(),
          'generalQuery': generalQuery,
          'body': bodyAverage,
          'mind': mindAverage,
          'achievement': achievementAverage,
          'relationship': relationshipAverage,
          'personalDevelopment': personalDevelopmentAverage,
        },
      );

      return response;
    }

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
    print('Error: ' + e.toString());
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
  print(generalQuery);
  print(bodyQueries);
  print(mindQueries);
  print(relationshipQueries);
  print(achievementsQueries);
  print(personalGrowthQueries);
  print(startingDate);

  try {
    http.Response response = await http.post(
      Uri.encodeFull(baseUrl + ':' + port + '/user/questions'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
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
getNudges() async {
  List nudges;

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

  try {
    // Fetching body nudges
    http.Response bodyResponse = await http.get(
      Uri.encodeFull(baseUrl + ':' + port + '/user/nudge/body'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );

    bodyNudges = [];
    nudges = json.decode(bodyResponse.body)['nudges'];
    if (nudges != null)
      nudges.forEach((_nudge) {
        bodyNudges.add(Nudge.jsonToObject(_nudge));
      });

    // Fetching mind nudges
    http.Response mindResponse = await http.get(
      Uri.encodeFull(baseUrl + ':' + port + '/user/nudge/mind'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );

    mindNudges = [];
    nudges = json.decode(mindResponse.body)['nudges'];
    if (nudges != null)
      nudges.forEach((_nudge) {
        mindNudges.add(Nudge.jsonToObject(_nudge));
      });

    // Fetching relationship nudges
    http.Response relationshipResponse = await http.get(
      Uri.encodeFull(baseUrl + ':' + port + '/user/nudge/relationship'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );
    relationshipNudges = [];
    nudges = json.decode(relationshipResponse.body)['nudges'];
    if (nudges != null)
      nudges.forEach((_nudge) {
        relationshipNudges.add(Nudge.jsonToObject(_nudge));
      });

    // Fetching achievement nudges
    http.Response achievementResponse = await http.get(
      Uri.encodeFull(baseUrl + ':' + port + '/user/nudge/achievement'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );
    achievementNudges = [];
    nudges = json.decode(achievementResponse.body)['nudges'];
    if (nudges != null)
      nudges.forEach((_nudge) {
        achievementNudges.add(Nudge.jsonToObject(_nudge));
      });

    // Fetching personalDevelopment nudges
    http.Response personalDevelopmentResponse = await http.get(
      Uri.encodeFull(baseUrl + ':' + port + '/user/nudge/personalDevelopment'),
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );
    personalGrowthNudges = [];
    nudges = json.decode(personalDevelopmentResponse.body)['nudges'];
    if (nudges != null)
      nudges.forEach((_nudge) {
        personalGrowthNudges.add(Nudge.jsonToObject(_nudge));
      });

    allNudges = [
      ...bodyNudges,
      ...mindNudges,
      ...relationshipNudges,
      ...achievementNudges,
      ...personalGrowthNudges,
    ];
  } catch (e) {
    print('Error' + e.toString());
  }

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
