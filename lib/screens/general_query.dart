// Fist question: "Do you love your job?"

import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/query_screens/custom_checkbox.dart';

class GeneralQuery extends StatefulWidget {
  @override
  _GeneralQueryState createState() => _GeneralQueryState();
}

class _GeneralQueryState extends State<GeneralQuery> {
  rebuildScreen({@required int optionNumber}) {
    setState(() {
      generalQuery = optionNumber.toDouble();
    });
    Navigator.pushNamed(context, '/bodyQueries');
  }

  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: Center(
          child: SizedBox(
            width: isLargeScreen
                ? min(850.0, MediaQuery.of(context).size.width * 0.9)
                : min(350.0, MediaQuery.of(context).size.width * 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLargeScreen
                    ? SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 60.0,
                            color: Colors.grey[300],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: Padding(
                    padding: isLargeScreen
                        ? EdgeInsets.all(30.0)
                        : const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFF8DAC9E),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                color: Colors.black12,
                                blurRadius: 5.0,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            'I love my job!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isLargeScreen ? 30 : 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomCheckBox(
                                title: 1,
                                subtitle: 'Strongly disagree',
                                isSelected: generalQuery == 1,
                                rebuildScreen: () =>
                                    rebuildScreen(optionNumber: 1),
                              ),
                              CustomCheckBox(
                                title: 2,
                                isSelected: generalQuery == 2,
                                rebuildScreen: () =>
                                    rebuildScreen(optionNumber: 2),
                              ),
                              CustomCheckBox(
                                title: 3,
                                subtitle: 'Indifferent',
                                isSelected: generalQuery == 3,
                                rebuildScreen: () =>
                                    rebuildScreen(optionNumber: 3),
                              ),
                              CustomCheckBox(
                                title: 4,
                                isSelected: generalQuery == 4,
                                rebuildScreen: () =>
                                    rebuildScreen(optionNumber: 4),
                              ),
                              CustomCheckBox(
                                title: 5,
                                subtitle: 'Strongly agree',
                                isSelected: generalQuery == 5,
                                rebuildScreen: () =>
                                    rebuildScreen(optionNumber: 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isLargeScreen
                    ? SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 60.0,
                            color: Colors.grey[300],
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/bodyQueries'),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          nextScreen: '/bodyQueries',
        ),
      ),
    );
  }
}
