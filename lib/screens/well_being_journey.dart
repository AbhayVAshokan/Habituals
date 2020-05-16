// Well Being Journey screen.

import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_tabbar.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../screens/well_being_journey_7days.dart';
import '../screens/well_being_journey_today.dart';
import '../screens/well_being_journey_66days.dart';

class WellBeingJourney extends StatefulWidget {
  @override
  _WellBeingJourneyState createState() => _WellBeingJourneyState();
}

class _WellBeingJourneyState extends State<WellBeingJourney>
    with TickerProviderStateMixin {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

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
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => exitDialog(context: context),
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
                        length: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 90.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: myTabBar(screen: 'journey'),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  WellBeingJourneyToday(),
                                  WellBeingJourney7Days(),
                                  WellBeingJourney66Days(),
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
                            _imageFilter = _containerHeight == 180.0
                                ? ImageFilter.blur()
                                : ImageFilter.blur(
                                    sigmaX: 2.0,
                                    sigmaY: 2.0,
                                  );
                            _containerHeight =
                                _containerHeight == 180.0 ? 0.0 : 180.0;
                          });
                        },
                        child: SizedBox(
                          width:
                              isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                          child: Column(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.yellow[300],
                                      width: isLargeScreen
                                          ? 800
                                          : mediaQuery.size.width * 0.9,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          'Well-Being Journey',
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
                                  'The Well-Being Journey shows you your progress in the Corporate Well-Being over time. In the dashboard you can choose a \"Today\", \"7 Days\" and \"66 Days\" time frame, as well as Dimension. Check the status of your nudges and see what impact it has on your Well-Being Pulse!',
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

  @override
  void dispose() {
    _fabController.dispose();
    _transitionController1.dispose();
    _transitionController2.dispose();
    super.dispose();
  }
}