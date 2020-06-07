// Well Being Journey screen.

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/exit_dialog.dart';
import '../resources/constants.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class WellBeingWall extends StatefulWidget {
  @override
  _WellBeingWallState createState() => _WellBeingWallState();
}

class _WellBeingWallState extends State<WellBeingWall>
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 90.0),
                        ],
                      ),
                      Positioned(
                        top: 75.0,
                        child: Container(
                          width:
                              isLargeScreen ? 900 : mediaQuery.size.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text('BN'),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: const Text(
                                        'What is on your mind? What success are you proud of? What tips do you have ?',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.black),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.share),
                                  Icon(Icons.image),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: SizedBox(
                          width:
                              isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width:
                                    isLargeScreen ? 800 : mediaQuery.size.width,
                                child: const Text('FAQ\'s & FEEDBACK'),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFa9bfb5),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                color: color_primary,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 75,
                                        padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                          left: 15.0,
                                        ),
                                        child: RaisedButton(
                                          padding: const EdgeInsets.all(10.0),
                                          color: Colors.white,
                                          onPressed: () {},
                                          child: const Text(
                                            'If you have any questions, click here for FAQs and support.',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 75,
                                        padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                          left: 15.0,
                                          right: 15.0,
                                        ),
                                        child: RaisedButton(
                                          padding: const EdgeInsets.all(10.0),
                                          color: Colors.white,
                                          onPressed: () {},
                                          child: const Text(
                                            'Please give us feedback so that we can improve.',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
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
                            _imageFilter = _containerHeight == 170.0
                                ? ImageFilter.blur()
                                : ImageFilter.blur(
                                    sigmaX: 2.0,
                                    sigmaY: 2.0,
                                  );
                            _containerHeight =
                                _containerHeight == 170.0 ? 0.0 : 170.0;
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
                                      color: color_header_background,
                                      width: isLargeScreen
                                          ? 800
                                          : mediaQuery.size.width * 0.9,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          'Well-Being Wall',
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
                                color: color_header_background,
                                height: _containerHeight,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 20.0,
                                ),
                                child: const Text(
                                  'The Well-Being Wall is the place to share successes and tips that helped you to tackle your nudges.\n\nPlease see the FAQ and Feedback section at the bottom to ask any questions and feedback you may have.',
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
