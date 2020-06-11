import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import './keys.dart';
import '../models/user.dart';
import './realtime_data.dart';

// Get the local storage directory path
Future<bool> getLocalPath() async {
  await getApplicationDocumentsDirectory().then(
    (Directory directory) => pathToDirectory = directory.path,
  );
  return true;
}

// Sync local user data with server.
Future syncWithServer() async {
  File dataFile = File(pathToDirectory + '/data.json');

  if (dataFile.existsSync()) {
    // Step 1: Sync with local data (in case user is using the app offline).
    isLoggedIn = true;
    var data = await json.decode(dataFile.readAsStringSync());

    currentUser = User(
      emailAddress: data['emailAddress'],
      age: data['age'],
      gender: data['gender'],
      mailingList: data['mailingList'],
      position: data['position'],
    );


    authToken = data['auth'];
    startingDate = DateTime.parse(data['startingDate']);
    generalQuery = data['generalQuery'];

    bodyAverage = data['body'];
    mindAverage = data['mind'];
    achievementAverage = data['achievement'];
    relationshipAverage = data['relationship'];
    personalDevelopmentAverage = data['personalDevelopment'];

    // Step 3: Sync with server (in case user uses multiple devices)
    try {
      http.Response response = await http.get(
        Uri.encodeFull(baseUrl + ':' + port + '/user/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': authToken,
        },
      );

      // Step 4: Sync realtime data
      Map jsonResponse = json.decode(response.body);

      currentUser = User(
        emailAddress: jsonResponse['emailAddress'],
        age: jsonResponse['age'] == null
            ? 20
            : int.parse(jsonResponse['age'].toString()),
        gender: jsonResponse['gender'],
        mailingList: jsonResponse['mailingList'] == 'subscribed',
        position: jsonResponse['position'],
      );
      startingDate = DateTime.parse(jsonResponse['startDate']);
      // generalQuery = double.parse(jsonResponse['generalQuery'].toString());

      // bodyAverage = double.parse(jsonResponse['bodyQuery'].toString());
      // mindAverage = double.parse(jsonResponse['mindQuery'].toString());
      // achievementAverage =
      //     double.parse(jsonResponse['achievementQuery'].toString());
      // relationshipAverage =
      //     double.parse(jsonResponse['relationshipQuery'].toString());
      // personalDevelopmentAverage =
      //     double.parse(jsonResponse['personalDevelopmentQuery'].toString());

      // Step 5: Sync cloud data with local data
      await writeToFile(
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

      return true;
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }
}

// Function to write the contents into file
writeToFile({@required Map<String, dynamic> content}) {
  String path = pathToDirectory + '/data.json';
  File dataFile = File(path);

  if (dataFile.existsSync()) {
    String readFile = dataFile.readAsStringSync();
    Map<String, dynamic> dataFileContents = json.decode(readFile);

    dataFileContents.addAll(content);
    dataFile.writeAsStringSync(jsonEncode(dataFileContents));
  } else {
    dataFile.createSync();
    dataFile.writeAsStringSync(jsonEncode(content));
  }
}
