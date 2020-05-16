// Nudge details (Nudge booster and the option for mark for completion / skip)

import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/nudge.dart';
import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/nudges/skip_nudge.dart';

class NudgeExpanded extends StatefulWidget {
  @override
  _NudgeExpandedState createState() => _NudgeExpandedState();
}

class _NudgeExpandedState extends State<NudgeExpanded>
    with TickerProviderStateMixin {
  ImageFilter _imageFilter = ImageFilter.blur();
  String imageUrl;
  double _skipOpacity = 0.0;
  List<Map<String, dynamic>> checkBoxes = [
    {
      'day': 'M',
      'selected': false,
    },
    {
      'day': 'T',
      'selected': false,
    },
    {
      'day': 'W',
      'selected': false,
    },
    {
      'day': 'T',
      'selected': false,
    },
    {
      'day': 'F',
      'selected': false,
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
    Nudge nudge = ModalRoute.of(context).settings.arguments;

    if (nudge.type == 'body')
      imageUrl = 'assets/images/nudges_screen/body.png';
    else if (nudge.type == 'mind')
      imageUrl = 'assets/images/nudges_screen/mind.png';
    else if (nudge.type == 'relationships')
      imageUrl = 'assets/images/nudges_screen/relationships.png';
    else if (nudge.type == 'achievements')
      imageUrl = 'assets/images/nudges_screen/achievements.png';
    else
      imageUrl = 'assets/images/nudges_screen/personal_development.png';

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(
              () {
                _imageFilter = ((menuBarHeight > 0) && !isLargeScreen)
                    ? ImageFilter.blur(
                        sigmaX: 2.0,
                        sigmaY: 2.0,
                      )
                    : ImageFilter.blur();
              },
            );
          },
        ),
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.0,
                      width: min(mediaQuery.size.width * 0.9, 800),
                      color: Colors.amber,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text('notification bar (to be developed)'),
                    ),
                    Container(
                      color: const Color(0xFF4C7160),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: isLargeScreen ? 80 : 60,
                      width: min(mediaQuery.size.width * 0.9, 800),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 50.0,
                            width: 50.0,
                          ),
                          Container(
                            width: min(mediaQuery.size.width * 0.9, 800) - 70,
                            alignment: Alignment.center,
                            child: Text(
                              '${nudge.type.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd|MM|yyyy').format(nudge.date),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              color: const Color(0xFFC6D7C4),
                              onPressed: () {},
                              child: Text(
                                nudge.status.compareTo('not completed') == 0
                                    ? 'to be done'
                                    : 'to be done',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: isLargeScreen
                                      ? 800
                                      : mediaQuery.size.width * 0.9,
                                  height: double.infinity,
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(20.0),
                                  color: const Color(0xFF8DAC9D),
                                  child: Text(
                                    nudge.nudge,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  width: isLargeScreen
                                      ? 800
                                      : mediaQuery.size.width * 0.9,
                                  height: double.infinity,
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(20.0),
                                  color: const Color(0xFF8DAC9D),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'NUDGE BOOSTER',
                                      children: [
                                        TextSpan(
                                          text: '\n\n' + nudge.nudgeBooster,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: 'Raleway'),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                          BackdropFilter(
                            filter: _imageFilter,
                            child: Container(
                              width: mediaQuery.size.width,
                              height: mediaQuery.size.height,
                              color: const Color(0x00000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 110.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              color: const Color(0xFFC6D7C4),
                              onPressed: () {},
                              child: const Text(
                                'Daily',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          Stack(
                            children: [
                              Row(
                                children: checkBoxes
                                    .map(
                                      (day) => Column(
                                        children: [
                                          Text(
                                            day['day'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: isLargeScreen ? 55 : 35,
                                            child: Checkbox(
                                              value: day['selected'],
                                              onChanged: (value) {
                                                setState(() {
                                                  day['selected'] =
                                                      !day['selected'];
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _skipOpacity =
                                          _skipOpacity == 0.0 ? 1.0 : 0.0;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Skip\nNudge',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(2.5),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        child: Icon(
                                          Icons.subdirectory_arrow_right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 35.0,
                right: 7.0,
                child: SkipNudge(
                  containerOpacity: _skipOpacity,
                  rebuildScreen: () {
                    setState(() {
                      _skipOpacity = 0.0;
                    });
                  },
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
