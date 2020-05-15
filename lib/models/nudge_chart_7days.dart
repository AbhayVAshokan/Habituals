import 'package:flutter/foundation.dart';

// Class to represent the barchart for nudges completed/not completed/skipped
class NudgeBarChart {
  final DateTime date;
  final String status;
  final int count;

  NudgeBarChart({
    @required this.date,
    @required this.status,
    @required this.count,
  });
}

// Class to represent the line graph for the score obtained for well-being pulse.
class NudgeLineChart {
  final double score;
  final DateTime date;

  NudgeLineChart({
    @required this.score,
    @required this.date,
  });
}
