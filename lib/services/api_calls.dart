import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// Register user data into the server
registerUser({
  @required String emailAddress,
  String gender,
  int age,
  String position,
  bool mailingList,
}) async {
  // API: /user/register: to upload the details of the user into the server.
  final databaseReference = Firestore.instance;
  await databaseReference.collection("users").document(emailAddress).setData(
    {
      'emailAddress': emailAddress,
      'gender': gender,
      'age': age,
      'position': position,
      'mailingList': mailingList,
    },
  );
}
