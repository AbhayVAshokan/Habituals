import 'package:flutter/foundation.dart';

// Class to represent the barchart for nudges completed/not completed/skipped
class NudgeLineGraph {
  final int dayCount;
  final String status;
  final int count;

  NudgeLineGraph({
    @required this.dayCount,
    @required this.status,
    @required this.count,
  });
}

// Class to represent the line graph for the score obtained for well-being pulse.
class NudgeWellBeingGraph {
  final double score;
  final int dayCount;

  NudgeWellBeingGraph({
    @required this.score,
    @required this.dayCount,
  });
}
