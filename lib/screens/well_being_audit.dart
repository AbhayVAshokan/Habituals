// Well Being Audit Screen.

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';
import '../widgets/well_being_audit/category_card.dart';

class WellBeingAudit extends StatefulWidget {
  @override
  _WellBeingAuditState createState() => _WellBeingAuditState();
}

class _WellBeingAuditState extends State<WellBeingAudit>
    with TickerProviderStateMixin {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  AnimationController _transitionController1;
  Animation<double> _scaleAnimation1;
  Animation _colorAnimation1;

  AnimationController _transitionController2;
  Animation _scaleAnimation2;
  Animation _colorAnimation2;

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;

    // Animation for page transition
    _transitionController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation1 =
        Tween<double>(begin: 1.0, end: 2000.0).animate(_transitionController1);
    _colorAnimation1 = ColorTween(
      begin: Colors.green,
      end: Colors.white,
    ).animate(_transitionController1);

    // FAB Page transition
    _transitionController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation2 =
        Tween<double>(begin: 1, end: 2000).animate(_transitionController2);
    _colorAnimation2 = ColorTween(
      begin: Colors.yellow,
      end: Colors.white,
    ).animate(_transitionController2);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;
    final List<Map<String, dynamic>> categoryData = [
      {
        'category': 'BODY',
        'data': bodyQueries,
        'imageUrl': 'assets/images/home_screen/body.png',
        'questions': bodyQuestions,
        'instructions':
            'The Well-Being Dimension \"Body\" is about physical fitness. When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
        'color': color_body,
      },
      {
        'category': 'MIND',
        'data': mindQueries,
        'imageUrl': 'assets/images/home_screen/mind.png',
        'questions': mindQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
        'color': color_mind,
      },
      {
        'category': 'RELATIONSHIPS',
        'data': relationshipQueries,
        'imageUrl': 'assets/images/home_screen/relationships.png',
        'questions': relationshipQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
        'color': color_relationship,
      },
      {
        'category': 'ACHIEVEMENTS',
        'data': achievementsQueries,
        'imageUrl': 'assets/images/home_screen/achievements.png',
        'questions': achievementQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
        'color': color_achievement,
      },
      {
        'category': 'PERSONAL DEVELOPMENT',
        'data': personalGrowthQueries,
        'imageUrl': 'assets/images/home_screen/personal_development.png',
        'questions': personalGrowthQuestions,
        'instructions':
            'This info is not provided (DUMMY DATA) When you get enough sleep, eat & drink well, exercise and take breaks regularly, your energy level is usually quite high',
        'color': color_personal_development,
      },
    ];

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => exitDialog(
          context: context,
        ),
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 90.0),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => CategoryCard(
                                    cardHeight: isLargeScreen
                                        ? 120
                                        : (constraints.maxHeight - 60) /
                                            categoryData.length,
                                    categoryData: categoryData[index],
                                  ),
                                  itemCount: categoryData.length,
                                ),
                              ),
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
                      child: SizedBox(
                        width:
                            isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                        child: Column(
                          children: [
                            Container(
                              height: 20.0,
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15.0,
                                    width: 15.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 5.0),
                                    child: const Text('1'),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      child: const Text(
                                        'Hey there! Check out your Well-Being Scores.',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  color: color_header_background,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'Well-Being Audit',
                                      style: const TextStyle(
                                        fontSize: 25.0,
                                      ),
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
                              color: color_header_background,
                              height: _containerHeight,
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
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: MenuDropDown(
                  animationController: _transitionController1,
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: AnimatedBuilder(
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation1.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _colorAnimation1.value,
                        shape: BoxShape.circle,
                      ),
                      height: 1.0,
                      width: 1.0,
                    ),
                  ),
                  animation: _colorAnimation1,
                ),
              ),
              Positioned(
                top: fabOffset.dy,
                left: fabOffset.dx,
                child: AnimatedBuilder(
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation2.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _colorAnimation2.value,
                        shape: BoxShape.circle,
                      ),
                      height: 1.0,
                      width: 1.0,
                    ),
                  ),
                  animation: _colorAnimation2,
                ),
              ),
              Positioned(
                top: fabOffset.dy,
                left: fabOffset.dx,
                child: MyFloatingActionButton(
                  rebuildScreen: () {
                    setState(() {});
                  },
                  transitionAnimationController: _transitionController2,
                ),
              ),
            ],
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            forwardButton: false,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _transitionController1.dispose();
    _transitionController2.dispose();
    super.dispose();
  }
}
