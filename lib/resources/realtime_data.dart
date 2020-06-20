// Stores the data which is required by different parts of the app at different times during a single execution.

import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/nudge.dart';
import '../models/nudge_chart_66days.dart';
import '../models/nudge_chart_7days.dart';

// Answers the the set of 25 + 1 questions asked at the beginning of the app
double generalQuery = 2.5;
List<double> bodyQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> mindQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> achievementsQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> relationshipQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> personalGrowthQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
DateTime startingDate = DateTime.now();

double bodyAverage = 2.5;
double mindAverage = 2.5;
double achievementAverage = 2.5;
double relationshipAverage = 2.5;
double personalDevelopmentAverage = 2.5;

// Set of 25 questions asked to the user at the initial login.
List<String> bodyQuestions = [
  'I feel full of energy most of the weekdays.',
  'I keep a well-balanced diet most of the weekdays.',
  'I exercise regularly (at least 2 times per week) to reduce stress levels.',
  'In the last week, I have suffered from sleeping problems.',
  'At work, I take breaks regularly (every 60 min) to recharge batteries.',
];

List<String> mindQuestions = [
  'I regularly reflect my stresslevel at work.',
  'Most of the time, there are positive vibes at work.',
  'My supervisor / leader makes sure that workloads are not unreasonable.',
  'I know how to manage my time so that I can focus and concentrate better.',
  'I take care of myself and know how to integrate mindful practices at work when I\'m stressed.',
];

List<String> relationshipQuestions = [
  'My supervisor or colleague seems to care about me as a person.',
  'I can count on my colleagues.',
  'Constructive feedback is given regularly in teams and by supervisor.',
  'Meetings are held effectively (e.g. clear agenda, appropriate timing).',
  'It\'s okay to do mistakes and talk openly about it.',
];

List<String> achievementQuestions = [
  'As a team, we regularly celebrate small and big successes.',
  'Know what is expected from me at work.',
  'My job challenges me and fits my competencies.',
  'A trustful working environment empowers me to push projects on my own.',
  'In the last week, I have received recognition for doing good work by my supervisor or colleagues.',
];

List<String> personalGrowthQuestions = [
  'At work, I have the possibility to do what I can do best every day.',
  'My supervisor talks regularly about my progress and encourages my development.',
  'I am fully aware of my strengths and weaknesses.',
  'The purpose of my company makes me feel my job is important.',
  'I can identify with the company\'s values.',
];

List<String> dayCounter = [
  'first',
  'second',
  'third',
  'forth',
  'fifth',
  'sixth',
  'seventh',
  'eigth',
  'ninth',
  'tenth',
  'eleventh',
  'twelfth',
  'thirteenth',
  'forteenth',
  'fifteenth',
  'sixteenth',
  'seventeenth',
  'eighteenth',
  'ninteenth',
  'twentieth',
  'twenty first',
  'twenty second',
  'twenty third',
  'twenty forth',
  'twenty fifth',
  'twenty sixth',
  'twenty seventh',
  'twenty eigth',
  'twenty ninth',
  'thirtieth',
  'thirty first',
  'thirty second',
  'thirty third',
  'thirty forth',
  'thirty fifth',
  'thirty sixth',
  'thirty seventh',
  'thirty eigth',
  'thirty ninth',
  'fortieth',
  'forty first',
  'forty second',
  'forty third',
  'forty forth',
  'forty fifth',
  'forty sixth',
  'forty seventh',
  'forty eigth',
  'forty ninth',
  'fiftieth',
  'fifty first',
  'fifty second',
  'fifty third',
  'fifty forth',
  'fifty fifth',
  'fifty sixth',
  'fifty seventh',
  'fifty eigth',
  'fifty ninth',
  'sixtieth',
  'sixty first',
  'sixty second',
  'sixty third',
  'sixty forth',
  'sixty fifth',
  'sixty sixth',
];

// Variable to represent the height of the menu-bar (which stores the link to the different screens).
double menuBarHeight;

// List of nudges received from the API.
List<Nudge> allNudges = [];
List<Nudge> allNudgesToday = [];
List<Nudge> allNudges7Days = [];
List<Nudge> allNudges66Days = [];
List<Nudge> bodyNudges = [];
List<Nudge> mindNudges = [];
List<Nudge> relationshipNudges = [];
List<Nudge> achievementNudges = [];
List<Nudge> personalGrowthNudges = [];

// Details of the currently login-ed user.
User currentUser;
String authToken;

// Details required to build the Well-Being Journey 7 Days graph.
List<NudgeBarChart> barChart7DaysCompleted = [];
List<NudgeBarChart> barChart7DaysNotCompleted = [];
List<NudgeBarChart> barChart7DaysSkipped = [];
List<NudgeLineChart> lineChart7Days = [];

// Details required to build the Well-Being Journet 66 Days graph.
List<NudgeLineGraph> lineGraph66DaysCompleted = [];
List<NudgeLineGraph> lineGraph66DaysNotCompleted = [];
List<NudgeLineGraph> lineGraph66DaysSkipped = [];
List<NudgeWellBeingGraph> lineWellBeing66Days = [];

// Well-Being Pulse Check

List<String> wellBeingPulseCheckQuestions = [
  'I feel physically fit and energized.',
  'The stress level is fine - I feel mentally on top of things.',
  'Team work works.',
  'I feel valued for my work and know what is expected from me.',
  'My job challenges me and fits my competencies.',
];
List<double> wellBeingPulseQueries = [2.5, 2.5, 2.5, 2.5, 2.5];

// Floating action button position
Offset fabOffset;

// Memos
List memos = [];
bool addingListItem = false;

// Local storage
String pathToDirectory;
bool isLoggedIn = false;
Map wellBeingPulseStatus;
