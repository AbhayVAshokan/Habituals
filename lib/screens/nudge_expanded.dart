import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habituals/models/nudge.dart';
import 'package:habituals/resources/realtime_data.dart';

import 'package:habituals/widgets/my_appbar.dart';
import 'package:habituals/widgets/menu_dropdown.dart';
import 'package:habituals/widgets/my_bottom_navbar.dart';
import 'package:intl/intl.dart';

class NudgeExpanded extends StatefulWidget {
  @override
  _NudgeExpandedState createState() => _NudgeExpandedState();
}

class _NudgeExpandedState extends State<NudgeExpanded> {
  ImageFilter _imageFilter = ImageFilter.blur();
  String imageUrl;
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

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;
    Nudge nudge = ModalRoute.of(context).settings.arguments;

    if (nudge.type == 'body')
      imageUrl = 'assets/images/nudges_screen/body.png';
    else if (nudge.type == 'mind')
      imageUrl = 'assets/images/nudges_screen/mind.png';
    else if (nudge.type == 'relationships')
      imageUrl = 'assets/images/nudges_screen/relationships.png';
    else if (nudge.type == 'achievements')
      imageUrl = 'assets/images/nudges_screen/achievements.png';
    else
      imageUrl = 'assets/images/nudges_screen/personal_development.png';

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(
              () {
                _imageFilter = menuBarHeight > 0 && !isLargeScreen
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
            width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.0,
                      width: min(mediaQuery.size.width * 0.9, 800),
                      color: Colors.amber,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text('notification bar (to be developed)'),
                    ),
                    Container(
                      color: const Color(0xFF4C7160),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: isLargeScreen ? 80 : 60,
                      width: min(mediaQuery.size.width * 0.9, 800),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 50.0,
                            width: 50.0,
                          ),
                          Container(
                            width: min(mediaQuery.size.width * 0.9, 800) - 70,
                            alignment: Alignment.center,
                            child: Text(
                              '${nudge.type.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd|MM|yyyy').format(nudge.date),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              color: const Color(0xFFC6D7C4),
                              onPressed: () {},
                              child: Text(
                                nudge.status.compareTo('not completed') == 0
                                    ? 'to be done'
                                    : 'kabali da',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
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
                              color: const Color(0xFF8DAC9D),
                              child: Text(
                                nudge.nudge,
                                style: const TextStyle(
                                  fontSize: 15.0,
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
                              padding: const EdgeInsets.all(20.0),
                              color: const Color(0xFF8DAC9D),
                              child: RichText(
                                text: TextSpan(
                                  text: 'NUDGE BOOSTER',
                                  children: [
                                    TextSpan(
                                      text: '\n\n' + nudge.nudgeBooster,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              color: const Color(0xFFC6D7C4),
                              onPressed: () {},
                              child: const Text(
                                'Daily',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          Stack(
                            children: [
                              Row(
                                children: checkBoxes
                                    .map(
                                      (day) => Column(
                                        children: [
                                          Text(
                                            day['day'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: isLargeScreen ? 55 : 35,
                                            child: Checkbox(
                                              value: day['selected'],
                                              onChanged: (value) {
                                                setState(() {
                                                  day['selected'] =
                                                      !day['selected'];
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Skip\nNudge',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(2.5),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        child: Icon(
                                          Icons.subdirectory_arrow_right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: MenuDropDown(),
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
}
