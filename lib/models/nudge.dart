import 'package:flutter/foundation.dart';

class Nudge {
  final String type;
  final String nudge;
  final String status;
  final DateTime date;
  final String nudgeBooster;

  Nudge({
    @required this.date,
    @required this.type,
    @required this.nudge,
    @required this.status,
    this.nudgeBooster,
  });

  factory Nudge.jsonToObject(jsonFile) {
    return Nudge(
      date: jsonFile['date'],
      type: jsonFile['type'],
      nudge: jsonFile['nudge'],
      status: jsonFile['status'],
      nudgeBooster: jsonFile['nudgeBooster'],
    );
  }
}
