import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../resources/realtime_data.dart';
import '../../models/nudge_chart_66days.dart';

class NudgeChart66Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<dynamic, int>> seriesList = [
      // Line 1: Completed Nudges
      charts.Series<NudgeLineGraph, int>(
        id: 'done',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.dayCount,
        measureFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.count,
        data: lineGraph66DaysCompleted,
        labelAccessorFn: (_, __) => 'done',
      ),

      // Line 2: Incomplete Nudges
      charts.Series<NudgeLineGraph, int>(
        id: 'not done',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.dayCount,
        measureFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.count,
        data: lineGraph66DaysNotCompleted,
        labelAccessorFn: (_, __) => 'not done',
      ),

      // Line 3: Skipped Nudges
      charts.Series<NudgeLineGraph, int>(
        id: 'skipped',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.dayCount,
        measureFn: (NudgeLineGraph nudgeLine, _) => nudgeLine.count,
        data: lineGraph66DaysSkipped,
        labelAccessorFn: (_, __) => 'skipped',
      ),

      // Line to represent well-being pulse
      charts.Series<NudgeWellBeingGraph, int>(
        id: 'Well Being Pulse ',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (NudgeWellBeingGraph score, _) => score.dayCount,
        measureFn: (NudgeWellBeingGraph score, _) => score.score,
        data: lineWellBeing66Days,
        labelAccessorFn: (_, __) => 'Well Being Pulse',
      )..setAttribute(charts.rendererIdKey, 'Well Being Pulse'),
    ];

    return charts.LineChart(seriesList,
        animate: true,
        animationDuration: const Duration(seconds: 2),
        customSeriesRenderers: [
          new charts.LineRendererConfig(customRendererId: 'Well Being Pulse')
        ]);
  }
}
