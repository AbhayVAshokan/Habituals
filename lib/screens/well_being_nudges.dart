// Well Being Nudges screen.

import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habituals/widgets/my_bottom_navbar.dart';

import '../widgets/my_tabbar.dart';
import '../widgets/my_appbar.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../screens/well_being_nudges_7days.dart';
import '../screens/well_being_nudges_today.dart';

class WellBeingNudges extends StatefulWidget {
  @override
  _WellBeingNudgesState createState() => _WellBeingNudgesState();
}

class _WellBeingNudgesState extends State<WellBeingNudges>
    with TickerProviderStateMixin {
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

  AnimationController _transitionController1;
  Animation<double> _scaleAnimation1;
  Animation _colorAnimation1;

  AnimationController _transitionController2;
  Animation _scaleAnimation2;
  Animation _colorAnimation2;

  AnimationController _fabController;
  Animation _fabScaleAnimation;
  Animation _fabColorAnimation;

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
      begin: Colors.green,
      end: Colors.white,
    ).animate(_transitionController2);

    // FAB animation
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fabScaleAnimation = Tween(
      begin: 50.0,
      end: 60.0,
    ).animate(_fabController);
    _fabColorAnimation = ColorTween(
      begin: const Color(0xFFffd31d),
      end: const Color(0xFFf57b51),
    ).animate(_fabController);
    _fabController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

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
                child: SizedBox(
                  width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                  child: Stack(
                    children: [
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 55.0),
                            myTabBar(screen: 'audit'),
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
                            SizedBox(
                              width: isLargeScreen
                                  ? 800
                                  : mediaQuery.size.width * 0.9,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.yellow[300],
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          'Well-Being Nudges',
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
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.decelerate,
                              color: Colors.yellow[300],
                              height: _containerHeight,
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
                bottom: 0.0,
                right: 0.0,
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
            ],
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            forwardButton: false,
          ),
          floatingActionButton: AnimatedBuilder(
            builder: (context, child) => SizedBox(
              width: _fabScaleAnimation.value,
              height: _fabScaleAnimation.value,
              child: FloatingActionButton(
                backgroundColor: _fabColorAnimation.value,
                onPressed: () {
                  _transitionController2.forward();
                  Timer(const Duration(milliseconds: 500), () {
                    Navigator.pushNamed(context, '/pulseCheck');
                  });
                  Timer(
                    const Duration(milliseconds: 1000),
                    () => _transitionController2.reverse(),
                  );
                },
                child: Icon(
                  Icons.notifications,
                  size: _fabScaleAnimation.value * 0.5,
                ),
              ),
            ),
            animation: _fabColorAnimation,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ),
      ),
    );
  }
}
