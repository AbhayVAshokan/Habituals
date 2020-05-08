import 'package:flutter/material.dart';

class ScreenSlideTransition extends PageRouteBuilder {
  final screen;
  final direction;
  ScreenSlideTransition({
    @required this.screen,
    this.direction = 'left',
  }) : super(
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin:
                    direction == 'left' ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
                end: Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondAnimation) {
            return screen;
          },
        );
}
