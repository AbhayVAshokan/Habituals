// Create custom user nudges

import 'dart:ui';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class CreateNudge extends StatefulWidget {
  @override
  _CreateNudgeState createState() => _CreateNudgeState();
}

class _CreateNudgeState extends State<CreateNudge>
    with TickerProviderStateMixin {
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
    final bool isLargeScreen = mediaQuery.size.width >= 900;

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
                        color: color_body.withOpacity(0.33),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        height: isLargeScreen ? 80 : 60,
                        width: min(mediaQuery.size.width * 0.9, 800),
                        child: SizedBox(
                          width:
                              isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
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
                                        triangleColor: color_body,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'CUSTOM NUDGE',
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
                                      .format(DateTime.now()),
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
                                      'Set Timing',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 26.0,
                              width: 100.0,
                              child: RaisedButton(
                                color: color_body,
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
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(20.0),
                                    color: color_card_background,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter title',
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
                                        TextField(
                                          keyboardType: TextInputType.multiline,
                                        ),
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
