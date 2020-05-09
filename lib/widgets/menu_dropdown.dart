import 'package:flutter/material.dart';
import 'package:habituals/resources/realtime_data.dart';

class MenuDropDown extends StatelessWidget {
  final List menuItems = [
    {
      'text': 'Well-Being Audit',
      'screen': '/home',
    },
    {
      'text': 'Well-Being Nudges',
      'screen': '/home',
    },
    {
      'text': 'Well-Being Journey',
      'screen': '/home',
    },
    {
      'text': 'Your Memos',
      'screen': '/home',
    },
    {
      'text': 'Support',
      'screen': '/home',
    },
    {
      'text': 'Logout',
      'screen': '/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
      width: isLandscape ? 200 : 130,
      height: menuBarHeight,
      color: const Color(0xFF8DAC9D),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, menuItems[index]['screen']),
            child: Container(
              height: isLandscape ? 50 : 35.0,
              width: isLandscape ? 200 : 175,
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
                  fontSize: isLandscape ? 15.00 : 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
