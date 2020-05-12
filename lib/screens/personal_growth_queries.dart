import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/query_screens/custom_checkbox.dart';

class PersonalGrowthQueries extends StatefulWidget {
  @override
  _PersonalGrowthQueriesState createState() => _PersonalGrowthQueriesState();
}

class _PersonalGrowthQueriesState extends State<PersonalGrowthQueries> {
  final PageController pageController = PageController();

  rebuildScreen({
    @required int optionNumber,
    @required int index,
  }) {
    setState(() {
      personalGrowthQueries[index] = optionNumber.toDouble();
    });
    if (index < 4)
      pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    if (index == 4) Navigator.pushNamed(context, '/displaySelection');
  }

  Widget questionPage({
    @required int index,
    @required String question,
    @required MediaQueryData mediaQuery,
  }) {
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLargeScreen
              ? Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(25.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 60.0,
                      color: Colors.grey[300],
                    ),
                    onPressed: () {
                      if (index > 0)
                        pageController.animateToPage(
                          index - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      else
                        Navigator.pop(context);
                    },
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: isLargeScreen
                ? min(600.0, MediaQuery.of(context).size.width * 0.9)
                : min(350.0, MediaQuery.of(context).size.width * 0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Personal Growth ${index + 1}/5',
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(5.0),
                ),
                Container(
                  height: 100.0,
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
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Text(
                    question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 25 : 18,
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
                        isSelected: personalGrowthQueries[index] == 1,
                        rebuildScreen: () => rebuildScreen(
                          optionNumber: 1,
                          index: index,
                        ),
                      ),
                      CustomCheckBox(
                        title: 2,
                        isSelected: personalGrowthQueries[index] == 2,
                        rebuildScreen: () => rebuildScreen(
                          optionNumber: 2,
                          index: index,
                        ),
                      ),
                      CustomCheckBox(
                        title: 3,
                        subtitle: 'Indifferent',
                        isSelected: personalGrowthQueries[index] == 3,
                        rebuildScreen: () => rebuildScreen(
                          optionNumber: 3,
                          index: index,
                        ),
                      ),
                      CustomCheckBox(
                        title: 4,
                        isSelected: personalGrowthQueries[index] == 4,
                        rebuildScreen: () => rebuildScreen(
                          optionNumber: 4,
                          index: index,
                        ),
                      ),
                      CustomCheckBox(
                        title: 5,
                        subtitle: 'Strongly agree',
                        isSelected: personalGrowthQueries[index] == 5,
                        rebuildScreen: () => rebuildScreen(
                          optionNumber: 5,
                          index: index,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isLargeScreen
              ? Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(25.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 60.0,
                      color: Colors.grey[300],
                    ),
                    onPressed: () {
                      if (index < 4)
                        pageController.animateToPage(
                          index + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      else
                        Navigator.pushNamed(context, '/displaySelection');
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: PageView.builder(
          itemBuilder: (context, index) => questionPage(
            question: personalGrowthQuestions[index],
            index: index,
            mediaQuery: mediaQuery,
          ),
          itemCount: personalGrowthQuestions.length,
          controller: pageController,
        ),
        bottomNavigationBar:
            myBottomNavbar(context: context, nextScreen: '/displaySelection'),
      ),
    );
  }
}
