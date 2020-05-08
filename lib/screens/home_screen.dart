import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/home_screen/category_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final List<Map<String, dynamic>> categoryData = [
      {
        'category': 'BODY',
        'data': bodyQueries,
        'imageUrl': 'assets/images/home_screen/body.png',
        'questions': bodyQuestions,
      },
      {
        'category': 'MIND',
        'data': mindQueries,
        'imageUrl': 'assets/images/home_screen/mind.png',
        'questions': mindQuestions,
      },
      {
        'category': 'RELATIONSHIPS',
        'data': relationshipQueries,
        'imageUrl': 'assets/images/home_screen/relationships.png',
        'questions': relationshipQuestions,
      },
      {
        'category': 'ACHIEVEMENTS',
        'data': achievementsQueries,
        'imageUrl': 'assets/images/home_screen/achievements.png',
        'questions': achievementQuestions,
      },
      {
        'category': 'PERSONAL DEVELOPMENT',
        'data': personalGrowthQueries,
        'imageUrl': 'assets/images/home_screen/personal_development.png',
        'questions': personalGrowthQuestions,
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20.0,
                width: min(mediaQuery.size.width * 0.9, 800),
                color: Colors.amber,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text('notification bar (to be developed)'),
              ),
              Container(
                color: Colors.yellow[300],
                width: min(mediaQuery.size.width * 0.9, 800),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: const Text(
                  'Well-Being Audit',
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: min(mediaQuery.size.width * 0.9, 600),
                      child: ListView.builder(
                        itemBuilder: (context, index) => CategoryCard(
                          cardHeight: min(
                              (constraints.maxHeight - 60) /
                                  categoryData.length,
                              100),
                          categoryData: categoryData[index],
                        ),
                        itemCount: categoryData.length,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
        ),
      ),
    );
  }
}
