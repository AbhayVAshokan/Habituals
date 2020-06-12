// Dropdown menu bar

import 'dart:async';

import 'package:flutter/material.dart';

import './logout_dialog.dart';
import '../resources/constants.dart';
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
      'screen': '/wall',
    },
    {
      'text': 'Logout',
      'screen': '/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
      width: 130,
      height: menuBarHeight,
      color: color_menu_background,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (menuItems[index]['text'] == 'Logout')
                logoutDialog(context: context);
              else {
                animationController.forward();
                Timer(const Duration(milliseconds: 500), () {
                  Navigator.pushReplacementNamed(
                      context, menuItems[index]['screen']);
                });
              }
            },
            child: Container(
              height: 35.0,
              width: 175,
              decoration: BoxDecoration(
                color: color_accent,
                border: Border(
                  left: BorderSide(
                    color: color_primary,
                    width: 5.0,
                  ),
                ),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              child: FittedBox(
                child: Text(
                  menuItems[index]['text'],
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
