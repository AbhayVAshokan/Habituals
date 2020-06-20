// Set of 5 questions asked twice every week to track the well-being of the user.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habituals/resources/local_storage.dart';

import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/query_screens/custom_checkbox.dart';

class WellBeingPulseCheck extends StatefulWidget {
  @override
  _WellBeingPulseCheckState createState() => _WellBeingPulseCheckState();
}

class _WellBeingPulseCheckState extends State<WellBeingPulseCheck> {
  final PageController pageController = PageController();

  rebuildScreen({
    @required int optionNumber,
    @required int index,
  }) {
    setState(() {
      wellBeingPulseQueries[index] = optionNumber.toDouble();
    });

    if (index < 4)
      pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    if (index == 4) Navigator.pop(context);
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
                    onPressed: () async {
                      if (index > 0)
                        pageController.animateToPage(
                          index - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      else {
                        await writeToFile(
                          content: {
                            'wellBeingPulseStatus': {
                              'date': DateTime.now(),
                              'status': true,
                            }
                          },
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: isLargeScreen
                ? min(600.0, MediaQuery.of(context).size.width * 0.9)
                : min(350.0, MediaQuery.of(context).size.width * 0.9),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 250.0,
                      width: 250.0,
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color_header_background,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 30.0),
                          const Text(
                            'WELL-BEING PULSE CHECK*',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 30.0),
                          ),
                          Image.asset(
                            'assets/images/pulse_icon.png',
                            fit: BoxFit.contain,
                            height: 75.0,
                          ),
                          Text(
                            '${index + 1}/5',
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
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
                        horizontal: 10.0,
                        vertical: 30.0,
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
                            isSelected: wellBeingPulseQueries[index] == 1,
                            rebuildScreen: () => rebuildScreen(
                              optionNumber: 1,
                              index: index,
                            ),
                          ),
                          CustomCheckBox(
                            title: 2,
                            isSelected: wellBeingPulseQueries[index] == 2,
                            rebuildScreen: () => rebuildScreen(
                              optionNumber: 2,
                              index: index,
                            ),
                          ),
                          CustomCheckBox(
                            title: 3,
                            subtitle: 'Indifferent',
                            isSelected: wellBeingPulseQueries[index] == 3,
                            rebuildScreen: () => rebuildScreen(
                              optionNumber: 3,
                              index: index,
                            ),
                          ),
                          CustomCheckBox(
                            title: 4,
                            isSelected: wellBeingPulseQueries[index] == 4,
                            rebuildScreen: () => rebuildScreen(
                              optionNumber: 4,
                              index: index,
                            ),
                          ),
                          CustomCheckBox(
                            title: 5,
                            subtitle: 'Strongly agree',
                            isSelected: wellBeingPulseQueries[index] == 5,
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
                index != 0
                    ? Positioned(
                        left: 0.0,
                        top: mediaQuery.size.height * 0.05,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/images/swipe_right.png',
                            height: mediaQuery.size.height * 0.04,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                index != 4
                    ? Positioned(
                        right: 0.0,
                        bottom: mediaQuery.size.height * 0.05,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/images/swipe_left.png',
                            height: mediaQuery.size.height * 0.04,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
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
                        Navigator.pushNamed(context, '/mindQueries');
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
            question: wellBeingPulseCheckQuestions[index],
            index: index,
            mediaQuery: mediaQuery,
          ),
          itemCount: wellBeingPulseCheckQuestions.length,
          controller: pageController,
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          forwardButton: false,
        ),
      ),
    );
  }
}
