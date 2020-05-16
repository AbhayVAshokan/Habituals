// Well being audit details screen for a particular category.

import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';

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
                                          backgroundColor:
                                              const Color(0xFF4C7160),
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
                        _containerHeight =
                            _containerHeight == 130 ? 0.0 : 130.0;
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: const Color(0xFFC6D7C4),
                              width: min(mediaQuery.size.width * 0.9, 800),
                              height: 70.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: Hero(
                                tag: widget.categoryData['imageUrl'],
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      widget.categoryData['imageUrl'],
                                      height: 50.0,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: FittedBox(
                                          child: Text(
                                            '${widget.categoryData['category'].toUpperCase() + ' AUDIT'}',
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50.0),
                                  ],
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
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate,
                          color: Color(0xFFC6D7C4),
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
