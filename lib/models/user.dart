import 'package:flutter/foundation.dart';

class User {
  final int age;
  final String gender;
  final String position;
  final bool mailingList;
  final DateTime createdAt;
  final String emailAddress;

  User({
    @required this.createdAt,
    @required this.emailAddress,
    this.age,
    this.gender,
    this.position,
    this.mailingList,

  });

  factory User.jsonToObject(jsonFile) {
    return User(
      age: jsonFile['age'],
      gender: jsonFile['gender'],
      position: jsonFile['position'],
      createdAt: jsonFile['createdAt'],
      mailingList: jsonFile['mailingList'],
      emailAddress: jsonFile['emailAddress'],
    );
  }
}
