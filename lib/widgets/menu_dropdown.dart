// Dropdown menu bar

import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/realtime_data.dart';

class MenuDropDown extends StatelessWidget {
  final AnimationController animationController;
  MenuDropDown({@required this.animationController});

  final List menuItems = [
    {
      'text': 'Well-Being Audit',
      'screen': '/home',
    },
    {
      'text': 'Well-Being Nudges',
      'screen': '/nudges',
    },
    {
      'text': 'Well-Being Journey',
      'screen': '/journey',
    },
    {
      'text': 'Your Memos',
      'screen': '/memos',
    },
    {
      'text': 'Support',
      'screen': '/support',
    },
    {
      'text': 'Logout',
      'screen': '/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
      width: isLargeScreen ? 200 : 130,
      height: menuBarHeight,
      color: const Color(0xFF8DAC9D),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              animationController.forward();
              Timer(
                  const Duration(milliseconds: 500),
                  () => Navigator.pushReplacementNamed(
                      context, menuItems[index]['screen']));
            },
            child: Container(
              height: isLargeScreen ? 50 : 35.0,
              width: isLargeScreen ? 200 : 175,
              decoration: BoxDecoration(
                color: const Color(0xFFC6D7C3),
                border: Border(
                  left: BorderSide(
                    color: Color(0xFF4C7160),
                    width: 5.0,
                  ),
                ),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                menuItems[index]['text'],
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: isLargeScreen ? 15.00 : 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
