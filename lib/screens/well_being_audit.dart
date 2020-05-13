// Well Being Audit Screen.

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/well_being_audit/category_card.dart';

class WellBeingAudit extends StatefulWidget {
  @override
  _WellBeingAuditState createState() => _WellBeingAuditState();
}

class _WellBeingAuditState extends State<WellBeingAudit> {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final List<Map<String, dynamic>> categoryData = [
      {
        'category': 'BODY',
        'data': bodyQueries,
        'imageUrl': 'assets/images/home_screen/body.png',
        'questions': bodyQuestions,
        'instructions':
            'The Well-Being Dimension \"Body\" is about physical fitness. When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
      },
      {
        'category': 'MIND',
        'data': mindQueries,
        'imageUrl': 'assets/images/home_screen/mind.png',
        'questions': mindQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
      },
      {
        'category': 'RELATIONSHIPS',
        'data': relationshipQueries,
        'imageUrl': 'assets/images/home_screen/relationships.png',
        'questions': relationshipQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
      },
      {
        'category': 'ACHIEVEMENTS',
        'data': achievementsQueries,
        'imageUrl': 'assets/images/home_screen/achievements.png',
        'questions': achievementQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
      },
      {
        'category': 'PERSONAL DEVELOPMENT',
        'data': personalGrowthQueries,
        'imageUrl': 'assets/images/home_screen/personal_development.png',
        'questions': personalGrowthQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(() {
              _imageFilter = menuBarHeight > 0 && !isLandscape
                  ? ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    )
                  : ImageFilter.blur();
            });
          },
        ),
        body: Stack(
          children: [
            Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 90.0),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              width: min(mediaQuery.size.width * 0.9, 800),
                              child: ListView.builder(
                                itemBuilder: (context, index) => CategoryCard(
                                  cardHeight: min(
                                      (constraints.maxHeight - 60) /
                                          categoryData.length,
                                      120),
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
                  BackdropFilter(
                    filter: _imageFilter,
                    child: Container(
                      width: 100,
                      height: mediaQuery.size.height,
                      color: const Color(0x00000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imageFilter = _containerHeight == 130.0
                            ? ImageFilter.blur()
                            : ImageFilter.blur(
                                sigmaX: 2.0,
                                sigmaY: 2.0,
                              );
                        _containerHeight =
                            _containerHeight == 130.0 ? 0.0 : 130;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 20.0,
                          width: min(mediaQuery.size.width * 0.9, 800),
                          color: Colors.amber,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('notification bar (to be developed)'),
                        ),
                        Stack(
                          children: [
                            Container(
                              color: Colors.yellow[300],
                              width: min(mediaQuery.size.width * 0.9, 800),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              child: Text(
                                'Well-Being Audit',
                                style: const TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -10.0,
                              right: -10.0,
                              child: IconButton(
                                icon: Transform.rotate(
                                  angle: -pi / 2,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.blueGrey,
                                    size: 20.0,
                                  ),
                                ),
                                onPressed: null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate,
                          color: Colors.yellow[300],
                          height: _containerHeight,
                          width: min(mediaQuery.size.width * 0.9, 800),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          child: const Text(
                            'The Well-Being Audit gives you an overview of your Well-Being Status Quo: Where are you good at (all scores > 2.5) and where is room for improvement (all scores < 2.5)?',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: MenuDropDown(),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
        ),
      ),
    );
  }
}
