// Well Being Nudges screen.

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_tabbar.dart';
import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../screens/well_being_nudges_7days.dart';
import '../screens/well_being_nudges_today.dart';

class WellBeingNudges extends StatefulWidget {
  @override
  _WellBeingNudgesState createState() => _WellBeingNudgesState();
}

class _WellBeingNudgesState extends State<WellBeingNudges> {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  List<Map<String, dynamic>> categories = [
    {
      'category': 'body',
      'imageUrl': 'assets/images/nudges_screen/body.png',
      'nudges': bodyNudges,
    },
    {
      'category': 'mind',
      'imageUrl': 'assets/images/nudges_screen/mind.png',
      'nudges': mindNudges,
    },
    {
      'category': 'relationships',
      'imageUrl': 'assets/images/nudges_screen/relationships.png',
      'nudges': relationshipNudges,
    },
    {
      'category': 'achievements',
      'imageUrl': 'assets/images/nudges_screen/achievements.png',
      'nudges': achievementNudges,
    },
    {
      'category': 'personal development',
      'imageUrl': 'assets/images/nudges_screen/personal_development.png',
      'nudges': personalGrowthNudges,
    },
  ];

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(() {
              _imageFilter = menuBarHeight > 0 && !isLargeScreen
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
              child: SizedBox(
                width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                child: Stack(
                  children: [
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 55.0),
                          myTabBar(),
                          Expanded(
                            child: TabBarView(
                              children: [
                                WellBeingNudgesToday(
                                  categories: categories,
                                ),
                                WellBeingNudges7Days(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    BackdropFilter(
                      filter: _imageFilter,
                      child: Container(
                        width: 100,
                        height: mediaQuery.size.height,
                        color: const Color(0x0000000),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageFilter = _containerHeight == 160.0
                              ? ImageFilter.blur()
                              : ImageFilter.blur(
                                  sigmaX: 2.0,
                                  sigmaY: 2.0,
                                );
                          _containerHeight =
                              _containerHeight == 160.0 ? 0.0 : 160;
                        });
                      },
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.yellow[300],
                                  width: min(mediaQuery.size.width * 0.9, 800),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: Text(
                                    'Well-Being Nudges',
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
                              'Well-Being Nudges give you impulses for a better Well-Being You. Daily challenges will help you to work on your behavior and mindset. Based on your scores, we recommend a set of nudges. Feel free to create your own!',
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
