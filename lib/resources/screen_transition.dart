// Classes representing different screen transitions (other than default screen transition).

import 'package:flutter/material.dart';

// Screen slides in from right to left: 300 milliseconds
class ScreenSlideTransition extends PageRouteBuilder {
  final screen;
  final direction;
  ScreenSlideTransition({
    @required this.screen,
    this.direction = 'left',
  }) : super(
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: direction == 'left'
                      ? Offset(1.0, 0.0)
                      : Offset(-1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondAnimation) => screen);
}

// Screen fades in: 1000 milliseconds
class ScreenFadeTransition extends PageRouteBuilder {
  final screen;
  ScreenFadeTransition({@required this.screen})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation.drive(
                  Tween(
                    begin: 0.0,
                    end: 1.0,
                  ),
                ),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondAnimation) => screen);
}
