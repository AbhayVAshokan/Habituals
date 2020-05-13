// Dummy data to simulate the workflow of the app till the backend is ready.

import '../models/user.dart';
import '../models/nudge.dart';

List<Nudge> dummyBodyNudges = [
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'body',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
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
    status: 'not completed',
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
    status: 'not completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'relationships',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
];

List<Nudge> dummyAchievementNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'achievements',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'achievements',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
];

List<Nudge> dummyPersonalGrowthNudges = [
  Nudge(
    date: DateTime.now(),
    type: 'personalGrowth',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
  ),
  Nudge(
    date: DateTime.now().add(Duration(days: 1)),
    type: 'personalGrowth',
    nudge: 'Take a 10 minutes walk in the fresh air',
    nudgeBooster:
        'Besides its good effect on your physical well-being, walks in the fresh air and nature boost your mood. Scientists found out that especially green spaces have a long-lastring positive effect on your stress-levels and happiness',
    status: 'not completed',
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
