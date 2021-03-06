// Well being audit details screen for a particular category.

import 'dart:ui';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../resources/constants.dart';

import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class AuditScreen extends StatefulWidget {
  final Map<String, dynamic> categoryData;
  AuditScreen({this.categoryData});

  @override
  _AuditScreenState createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen>
    with TickerProviderStateMixin {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  AnimationController _transitionController1;
  AnimationController _colorAnimationController;

  AnimationController _transitionController2;
  Animation<double> _scaleAnimation1;
  Animation<double> _scaleAnimation2;
  Animation _colorAnimation1;
  Animation _colorAnimation2;
  Animation _colorAnimation3;

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

    // Instruction dropdown animation
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation3 =
        ColorTween(begin: const Color(0xffe3e6f0), end: Colors.white)
            .animate(_colorAnimationController);
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
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 70.0),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, parentConstraints) => Container(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 30.0,
                            ),
                            width: min(mediaQuery.size.width * 0.9, 800),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                height: isLargeScreen ? 100 : 75,
                                child: LayoutBuilder(
                                  builder: (context, constraints) => Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircleAvatar(
                                          radius: min(
                                              constraints.maxWidth * 0.06,
                                              20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: color_primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth - 120.0,
                                        child: Text(
                                          widget.categoryData['questions']
                                              [index],
                                          style: TextStyle(
                                            fontSize:
                                                isLargeScreen ? 18.0 : 15.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5.0),
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF8DAC9E),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Text(
                                            widget.categoryData['data'][index]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: widget.categoryData['data'].length,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  BackdropFilter(
                    filter: _imageFilter,
                    child: Container(
                      width: 100,
                      height: mediaQuery.size.height,
                      color: const Color(0x000000000),
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
                        _containerHeight == 130
                            ? _colorAnimationController.reverse()
                            : _colorAnimationController.forward();
                        _containerHeight =
                            _containerHeight == 130 ? 0.0 : 130.0;
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _colorAnimation3,
                              builder: (context, child) => Container(
                                color: _colorAnimation3.value,
                                width: min(mediaQuery.size.width * 0.9, 800),
                                height: 70.0,
                                alignment: Alignment.center,
                                child: LayoutBuilder(
                                  builder: (context, constraints) => Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          CustomPaint(
                                            child: Container(
                                              height: constraints.maxHeight,
                                              width: constraints.maxHeight *
                                                  0.75,
                                            ),
                                            painter: DrawTriangleShape(
                                              triangleColor: widget
                                                  .categoryData['color'],
                                            ),
                                          ),
                                          Image.asset(
                                            widget.categoryData['imageUrl'],
                                            height: min(
                                                37, constraints.maxHeight),
                                            width: min(
                                                37, constraints.maxHeight),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: AutoSizeText(
                                            '${widget.categoryData['category'].toUpperCase() + ' AUDIT'}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.75,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                    ],
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
                            )
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        AnimatedBuilder(
                          animation: _colorAnimation3,
                          builder: (context, child) => AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.decelerate,
                            color: _colorAnimation3.value,
                            width: min(mediaQuery.size.width * 0.9, 800),
                            height: _containerHeight,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              widget.categoryData['instructions'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15.0,
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
