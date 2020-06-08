// Nudge details (Nudge booster and the option for mark for completion / skip)

import 'dart:ui';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/nudge.dart';
import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';
import '../widgets/well_being_nudges/skip_nudge.dart';

class NudgeExpanded extends StatefulWidget {
  final Nudge nudge;
  final Color color;

  NudgeExpanded({
    this.nudge,
    this.color,
  });

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
    final bool isLargeScreen = mediaQuery.size.width >= 900;
    if (widget.nudge.type == 'body')
      imageUrl = 'assets/images/home_screen/body.png';
    else if (widget.nudge.type == 'mind')
      imageUrl = 'assets/images/home_screen/mind.png';
    else if (widget.nudge.type == 'relationships')
      imageUrl = 'assets/images/home_screen/relationships.png';
    else if (widget.nudge.type == 'achievements')
      imageUrl = 'assets/images/home_screen/achievements.png';
    else
      imageUrl = 'assets/images/home_screen/personal_development.png';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          child: SizedBox(
            width: mediaQuery.size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  'Make sure you tick your nudges to see your progress :-)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Hero(
                        tag:
                            '${widget.nudge.type.toUpperCase() == 'PERSONALGROWTH' ? 'PERSONAL GROWTH' : widget.nudge.type.toUpperCase()}_container',
                        child: Container(
                          color: widget.color.withOpacity(0.33),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: isLargeScreen ? 80 : 60,
                          width: min(mediaQuery.size.width * 0.9, 800),
                          child: SizedBox(
                            width: isLargeScreen
                                ? 800
                                : mediaQuery.size.width * 0.9,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      CustomPaint(
                                        child: Container(
                                          height: constraints.maxHeight,
                                          width: constraints.maxHeight * 0.75,
                                        ),
                                        painter: DrawTriangleShape(
                                          triangleColor: widget.color,
                                        ),
                                      ),
                                      Image.asset(
                                        imageUrl,
                                        height: min(
                                            35, constraints.maxHeight * 0.95),
                                        width: min(
                                            35, constraints.maxHeight * 0.95),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.nudge.type.toUpperCase() ==
                                                'PERSONALGROWTH'
                                            ? 'PERSONAL GROWTH'
                                            : '${widget.nudge.type.toUpperCase()}',
                                        style: const TextStyle(
                                          fontSize: 27.0,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('dd|MM|yyyy')
                                      .format(widget.nudge.date),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  height: 26.0,
                                  width: 100.0,
                                  child: RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () {},
                                    child: Text(
                                      'Daily',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 26.0,
                                  width: 100.0,
                                  child: RaisedButton(
                                    color: widget.color,
                                    onPressed: () {},
                                    child: Text(
                                      'Done',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                SizedBox(
                                  height: 26.0,
                                  width: 100.0,
                                  child: RaisedButton(
                                    color: widget.color,
                                    onPressed: () {},
                                    child: Text(
                                      'Skip',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
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
                                    color: color_card_background,
                                    child: AutoSizeText(
                                      widget.nudge.nudge,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10.0,
                                    ),
                                    color: color_card_background,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'NUDGE BOOSTER',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        AutoSizeText(
                                          widget.nudge.nudgeBooster,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
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
                  top: fabOffset.dy,
                  left: fabOffset.dx,
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
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
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

// Class to draw a triangle.
class DrawTriangleShape extends CustomPainter {
  final Color triangleColor;
  DrawTriangleShape({
    @required this.triangleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = Paint()
      ..color = triangleColor
      ..style = PaintingStyle.fill;

    var path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height / 2)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
