// Custom floating action button for well-being pulse notification.

import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/realtime_data.dart';

class MyFloatingActionButton extends StatefulWidget {
  final Function rebuildScreen;
  final AnimationController transitionAnimationController;

  MyFloatingActionButton({
    @required this.rebuildScreen,
    @required this.transitionAnimationController,
  });

  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation scaleAnimation;
  Animation colorAnimation;

  @override
  void initState() {
    // FAB animation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    scaleAnimation = Tween(
      begin: 30.0,
      end: 32.0,
    ).animate(animationController);
    colorAnimation = ColorTween(
      end: const Color(0xeeffd31d),
      begin: const Color(0xf57b51),
    ).animate(animationController);
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    var pulseCheckDay = false;

    if (DateTime.now().difference(startingDate).inDays % 3 == 0 &&
        (wellBeingPulseStatus == null ||
            DateTime.now().difference(wellBeingPulseStatus['date']).inDays !=
                0)) {
      pulseCheckDay = true;
      print(currentUser.emailAddress);
      wellBeingPulseStatus = {
        'date': DateTime.now(),
        'status': true,
      };
    }

    print(wellBeingPulseStatus);
    print(DateTime.now().difference(wellBeingPulseStatus['date']).inDays);

    return pulseCheckDay
        ? Draggable(
            feedback: FloatingActionButton(
              backgroundColor: colorAnimation.value,
              onPressed: () {
                widget.transitionAnimationController.forward();
                Timer(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/pulseCheck');
                });
                Timer(
                  const Duration(milliseconds: 1000),
                  () => widget.transitionAnimationController.reverse(),
                );
              },
              child: Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
            childWhenDragging: Container(),
            child: AnimatedBuilder(
              builder: (context, child) => SizedBox(
                width: scaleAnimation.value,
                height: scaleAnimation.value,
                child: FloatingActionButton(
                  backgroundColor: colorAnimation.value,
                  onPressed: () {
                    widget.transitionAnimationController.forward();
                    Timer(const Duration(milliseconds: 500), () {
                      Navigator.pushNamed(context, '/pulseCheck');
                    });
                    Timer(
                      const Duration(milliseconds: 1000),
                      () => widget.transitionAnimationController.reverse(),
                    );
                  },
                  child: Icon(
                    Icons.notifications,
                    size: scaleAnimation.value * 0.5,
                  ),
                ),
              ),
              animation: colorAnimation,
            ),
            onDragEnd: (details) {
              double x, y;

              if (details.offset.dx >= 0 &&
                  details.offset.dy >= 0 &&
                  details.offset.dx <= mediaQuery.size.width - 35 &&
                  details.offset.dy <=
                      mediaQuery.size.height - 155 - mediaQuery.padding.top) {
                x = details.offset.dx;
                y = details.offset.dy;
              }
              if (details.offset.dx < 0)
                x = 0;
              else if (details.offset.dx > mediaQuery.size.width - 35)
                x = mediaQuery.size.width - 35;
              else
                x = details.offset.dx;
              if (details.offset.dy < 50 + mediaQuery.padding.top)
                y = 0;
              else if (details.offset.dy >
                  mediaQuery.size.height - 175 - mediaQuery.padding.top)
                y = mediaQuery.size.height - 175 - mediaQuery.padding.top;
              else
                y = details.offset.dy - 60;

              fabOffset = Offset(x, y);
              widget.rebuildScreen();
            },
          )
        : SizedBox.shrink();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
