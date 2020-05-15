import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../models/nudge_chart_7days.dart';
import '../../resources/realtime_data.dart';

class NudgeChart7Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<dynamic, String>> seriesList = [
      // Bar 1: Completed Nudges
      charts.Series<NudgeBarChart, String>(
        id: 'done',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (NudgeBarChart nudgeBar, _) =>
            DateFormat('dd|MM').format(nudgeBar.date),
        measureFn: (NudgeBarChart nudgeBar, _) => nudgeBar.count,
        data: barChart7DaysCompleted,
        labelAccessorFn: (_, __) => 'done',
      ),

      // Bar 2: Incomplete Nudges
      charts.Series<NudgeBarChart, String>(
        id: 'not done',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (NudgeBarChart nudgeBar, _) =>
            DateFormat('dd|MM').format(nudgeBar.date),
        measureFn: (NudgeBarChart nudgeBar, _) => nudgeBar.count,
        data: barChart7DaysNotCompleted,
        labelAccessorFn: (_, __) => 'not done',
      ),

      // Bar 3: Skipped Nudges
      charts.Series<NudgeBarChart, String>(
        id: 'skipped',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (NudgeBarChart nudgeBar, _) =>
            DateFormat('dd|MM').format(nudgeBar.date),
        measureFn: (NudgeBarChart nudgeBar, _) => nudgeBar.count,
        data: barChart7DaysNotCompleted,
        labelAccessorFn: (_, __) => 'skipped',
      ),

      // Line to represent well-being pulse
      new charts.Series<NudgeLineChart, String>(
        id: 'Well Being Pulse ',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (NudgeLineChart score, _) =>
            DateFormat('dd|MM').format(score.date),
        measureFn: (NudgeLineChart score, _) => score.score,
        data: lineChart7Days,
        labelAccessorFn: (_, __) => 'Well Being Pulse',
      )..setAttribute(charts.rendererIdKey, 'Well Being Pulse'),
    ];

    return charts.OrdinalComboChart(seriesList,
        animate: true,
        animationDuration: const Duration(seconds: 2),
        domainAxis: charts.AxisSpec<String>(
          showAxisLine: true,
        ),
        primaryMeasureAxis: charts.AxisSpec(showAxisLine: true),
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped),
        customSeriesRenderers: [
          new charts.LineRendererConfig(customRendererId: 'Well Being Pulse')
        ]);
  }
}
