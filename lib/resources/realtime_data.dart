// Stores the data which is required by different parts of the app at different times during a single execution.

import '../models/user.dart';
import '../models/nudge.dart';

// Answers the the set of 25 + 1 questions asked at the beginning of the app
double generalQuery = 2.5;
List<double> bodyQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> mindQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> achievementsQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> relationshipQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
List<double> personalGrowthQueries = [2.5, 2.5, 2.5, 2.5, 2.5];
DateTime startingDate = DateTime.now();

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
  'I take care of myself and know how to integrate mindful practives at work when I\'m stressed.',
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
  'Know what is exppected from me at work.',
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

// Variable to represent the height of the menu-bar (which stores the link to the different screens).
double menuBarHeight;

// List of nudges received from the API.
List<Nudge> bodyNudges = [];
List<Nudge> mindNudges = [];
List<Nudge> relationshipNudges = [];
List<Nudge> achievementNudges = [];
List<Nudge> personalGrowthNudges = [];

// Details of the currently login-ed user.
User currentUser;
String authToken;
