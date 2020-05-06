import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/query_screens/custom_checkbox.dart';

class RelationshipQueries extends StatefulWidget {
  @override
  _RelationshipQueriesState createState() => _RelationshipQueriesState();
}

class _RelationshipQueriesState extends State<RelationshipQueries> {
  List<String> questions = [
    'My supervisor or colleague seems to care about me as a person.',
    'I can count on my colleagues.',
    'Constructive feedback is given regularly in teams and by supervisor.',
    'Meetings are held effectively (e.g. clear agenda, appropriate timing).',
    'It\'s okay to do mistakes and talk openly about it.',
  ];
  final PageController pageController = PageController();

  rebuildScreen({
    @required int optionNumber,
    @required int index,
  }) {
    setState(() {
      relationshipQueries[index] = optionNumber;
    });
    if (index < 4)
      pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    else if (!relationshipQueries.contains(0))
      Navigator.pushNamed(context, '/achievementsQueries');
  }

  Widget questionPage({
    @required String question,
    @required int index,
  }) {
    return Center(
      child: SizedBox(
        width: min(350.0, MediaQuery.of(context).size.width * 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Relationships ${index + 1}/5',
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
            Container(
              height: 100.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF8DAC9E),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                    color: Colors.black12,
                    blurRadius: 5.0,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCheckBox(
                    title: 1,
                    subtitle: 'Strongly disagree',
                    isSelected: relationshipQueries[index] == 1,
                    rebuildScreen: () => rebuildScreen(
                      optionNumber: 1,
                      index: index,
                    ),
                  ),
                  CustomCheckBox(
                    title: 2,
                    isSelected: relationshipQueries[index] == 2,
                    rebuildScreen: () => rebuildScreen(
                      optionNumber: 2,
                      index: index,
                    ),
                  ),
                  CustomCheckBox(
                    title: 3,
                    subtitle: 'Indifferent',
                    isSelected: relationshipQueries[index] == 3,
                    rebuildScreen: () => rebuildScreen(
                      optionNumber: 3,
                      index: index,
                    ),
                  ),
                  CustomCheckBox(
                    title: 4,
                    isSelected: relationshipQueries[index] == 4,
                    rebuildScreen: () => rebuildScreen(
                      optionNumber: 4,
                      index: index,
                    ),
                  ),
                  CustomCheckBox(
                    title: 5,
                    subtitle: 'Strongly agree',
                    isSelected: relationshipQueries[index] == 5,
                    rebuildScreen: () => rebuildScreen(
                      optionNumber: 5,
                      index: index,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: PageView.builder(
          itemBuilder: (context, index) => questionPage(
            question: questions[index],
            index: index,
          ),
          itemCount: questions.length,
          controller: pageController,
        ),
        bottomNavigationBar: myBottomNavbar(context: context),
      ),
    );
  }
}
