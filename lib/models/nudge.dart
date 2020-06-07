// Class to store the parameters of an individual nudge

import 'package:flutter/foundation.dart';

class Nudge {
  final String id;
  final String type;
  final String nudge;
  final String status;
  final DateTime date;
  final String nudgeBooster;

  Nudge({
    @required this.id,
    @required this.date,
    @required this.type,
    @required this.nudge,
    @required this.status,
    this.nudgeBooster,
  });

  // Function to convert json file obtained as response to API call into Nudge class object
  factory Nudge.jsonToObject(jsonFile) {
    return Nudge(
      id: jsonFile['id'],
      date: jsonFile['date'],
      type: jsonFile['type'],
      nudge: jsonFile['nudge'],
      status: jsonFile['status'],
      nudgeBooster: jsonFile['nudgeBooster'],
    );
  }
}
