// Dummy data to simulate the workflow of the app till the backend is ready.

import 'package:habituals/models/nudge_chart_66days.dart';
import 'package:habituals/models/nudge_chart_7days.dart';

import '../models/user.dart';
import '../models/nudge.dart';

List<Nudge> dummyBodyNudges = [
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'body',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'completed',
  ),
  Nudge(
    date: DateTime.now(),
    type: 'body',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 2)),
    type: 'body',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'skipped',
  ),
];

List<Nudge> dummyMindNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'mind',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'mind',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
];

List<Nudge> dummyRelationshipNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'relationships',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'skipped',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'relationships',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'skipped',
  ),
];

List<Nudge> dummyAchievementNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'achievements',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'achievements',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'completed',
  ),
];

List<Nudge> dummyPersonalGrowthNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'personalGrowth',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'skipped',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'personalGrowth',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'completed',
  ),
];

User dummyUser = User(
  emailAddress: 'abhayvashokan@gmail.com',
  createdAt: DateTime.now(),
  age: 20,
  gender: 'male',
  mailingList: false,
  position: 'Intern',
);

List<NudgeBarChart> dummyBarChart7Days = [
  NudgeBarChart(date: DateTime.now(), status: 'completed', count: 10),
  NudgeBarChart(date: DateTime.now(), status: 'not completed', count: 3),
  NudgeBarChart(date: DateTime.now(), status: 'skipped', count: 4),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'completed',
      count: 11),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'not completed',
      count: 1),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'skipped',
      count: 4),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'completed',
      count: 12),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'not completed',
      count: 1),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'skipped',
      count: 5),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'completed',
      count: 5),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'not completed',
      count: 10),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'skipped',
      count: 2),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: 'completed',
      count: 3),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: 'not completed',
      count: 4),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: 'skipped',
      count: 4),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'completed',
      count: 6),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'not completed',
      count: 3),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'skipped',
      count: 1),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 6)),
      status: 'completed',
      count: 11),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 6)),
      status: 'not completed',
      count: 1),
  NudgeBarChart(
      date: DateTime.now().subtract(const Duration(days: 6)),
      status: 'skipped',
      count: 6),
];

List<NudgeLineChart> dummyLineChart7Days = [
  NudgeLineChart(score: 4, date: DateTime.now()),
  NudgeLineChart(
      score: 3.5, date: DateTime.now().subtract(const Duration(days: 1))),
  NudgeLineChart(
      score: 2, date: DateTime.now().subtract(const Duration(days: 2))),
  NudgeLineChart(
      score: 10, date: DateTime.now().subtract(const Duration(days: 3))),
  NudgeLineChart(
      score: 1, date: DateTime.now().subtract(const Duration(days: 4))),
  NudgeLineChart(
      score: 3, date: DateTime.now().subtract(const Duration(days: 5))),
  NudgeLineChart(
      score: 4.7, date: DateTime.now().subtract(const Duration(days: 6))),
];

List<NudgeLineGraph> dummyLineChart66Days = [
  NudgeLineGraph(dayCount: 0, status: 'completed', count: 10),
  NudgeLineGraph(dayCount: 0, status: 'not completed', count: 4),
  NudgeLineGraph(dayCount: 0, status: 'skipped', count: 4),
  NudgeLineGraph(dayCount: 22, status: 'completed', count: 13),
  NudgeLineGraph(dayCount: 22, status: 'not completed', count: 2),
  NudgeLineGraph(dayCount: 22, status: 'skipped', count: 10),
  NudgeLineGraph(dayCount: 44, status: 'completed', count: 2),
  NudgeLineGraph(dayCount: 44, status: 'not completed', count: 7),
  NudgeLineGraph(dayCount: 44, status: 'skipped', count: 7),
  NudgeLineGraph(dayCount: 66, status: 'completed', count: 7),
  NudgeLineGraph(dayCount: 66, status: 'not completed', count: 10),
  NudgeLineGraph(dayCount: 66, status: 'skipped', count: 12),
];

List<NudgeWellBeingGraph> dummyNudgeWellBeingGraph = [
  NudgeWellBeingGraph(dayCount: 0, score: 0),
  NudgeWellBeingGraph(dayCount: 1, score: 1),
  NudgeWellBeingGraph(dayCount: 2, score: 1.2),
  NudgeWellBeingGraph(dayCount: 3, score: 2),
  NudgeWellBeingGraph(dayCount: 4, score: 3),
  NudgeWellBeingGraph(dayCount: 5, score: 3.2),
  NudgeWellBeingGraph(dayCount: 6, score: 3.2),
  NudgeWellBeingGraph(dayCount: 7, score: 3.5),
  NudgeWellBeingGraph(dayCount: 8, score: 4),
  NudgeWellBeingGraph(dayCount: 9, score: 4),
  NudgeWellBeingGraph(dayCount: 10, score: 5),
  NudgeWellBeingGraph(dayCount: 11, score: 4.5),
  NudgeWellBeingGraph(dayCount: 12, score: 4.3),
  NudgeWellBeingGraph(dayCount: 13, score: 3),
  NudgeWellBeingGraph(dayCount: 14, score: 2),
  NudgeWellBeingGraph(dayCount: 15, score: 2.1),
  NudgeWellBeingGraph(dayCount: 16, score: 2.2),
  NudgeWellBeingGraph(dayCount: 17, score: 2.2),
  NudgeWellBeingGraph(dayCount: 18, score: 2.5),
  NudgeWellBeingGraph(dayCount: 19, score: 3),
  NudgeWellBeingGraph(dayCount: 20, score: 3.2),
  NudgeWellBeingGraph(dayCount: 21, score: 3),
  NudgeWellBeingGraph(dayCount: 22, score: 3.5),
  NudgeWellBeingGraph(dayCount: 23, score: 3),
  NudgeWellBeingGraph(dayCount: 24, score: 3),
  NudgeWellBeingGraph(dayCount: 25, score: 3),
  NudgeWellBeingGraph(dayCount: 26, score: 3.6),
  NudgeWellBeingGraph(dayCount: 27, score: 4),
  NudgeWellBeingGraph(dayCount: 28, score: 4.2),
  NudgeWellBeingGraph(dayCount: 29, score: 4.6),
  NudgeWellBeingGraph(dayCount: 30, score: 5),
  NudgeWellBeingGraph(dayCount: 31, score: 5),
  NudgeWellBeingGraph(dayCount: 32, score: 4.5),
  NudgeWellBeingGraph(dayCount: 33, score: 4.5),
  NudgeWellBeingGraph(dayCount: 34, score: 4),
  NudgeWellBeingGraph(dayCount: 35, score: 4.2),
  NudgeWellBeingGraph(dayCount: 36, score: 4.1),
  NudgeWellBeingGraph(dayCount: 37, score: 3.2),
  NudgeWellBeingGraph(dayCount: 38, score: 3),
  NudgeWellBeingGraph(dayCount: 39, score: 3.5),
  NudgeWellBeingGraph(dayCount: 40, score: 3.8),
  NudgeWellBeingGraph(dayCount: 41, score: 4),
  NudgeWellBeingGraph(dayCount: 42, score: 4.2),
  NudgeWellBeingGraph(dayCount: 43, score: 4.3),
  NudgeWellBeingGraph(dayCount: 44, score: 4),
  NudgeWellBeingGraph(dayCount: 45, score: 3.5),
  NudgeWellBeingGraph(dayCount: 46, score: 3.8),
  NudgeWellBeingGraph(dayCount: 47, score: 3.9),
  NudgeWellBeingGraph(dayCount: 48, score: 3.5),
  NudgeWellBeingGraph(dayCount: 49, score: 3.1),
  NudgeWellBeingGraph(dayCount: 50, score: 3),
  NudgeWellBeingGraph(dayCount: 51, score: 3.6),
  NudgeWellBeingGraph(dayCount: 52, score: 2.5),
  NudgeWellBeingGraph(dayCount: 53, score: 1),
  NudgeWellBeingGraph(dayCount: 54, score: 2),
  NudgeWellBeingGraph(dayCount: 55, score: 3),
  NudgeWellBeingGraph(dayCount: 56, score: 3),
  NudgeWellBeingGraph(dayCount: 57, score: 3),
  NudgeWellBeingGraph(dayCount: 58, score: 4),
  NudgeWellBeingGraph(dayCount: 59, score: 4.5),
  NudgeWellBeingGraph(dayCount: 61, score: 4.1),
  NudgeWellBeingGraph(dayCount: 62, score: 4),
  NudgeWellBeingGraph(dayCount: 63, score: 5),
  NudgeWellBeingGraph(dayCount: 64, score: 4.6),
  NudgeWellBeingGraph(dayCount: 65, score: 4.4),
  NudgeWellBeingGraph(dayCount: 66, score: 4),
];
