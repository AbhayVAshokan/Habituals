import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/query_screens/custom_checkbox.dart';

class DisplaySelectionScreen extends StatefulWidget {
  @override
  DisplaySelectionScreenState createState() => DisplaySelectionScreenState();
}

class DisplaySelectionScreenState extends State<DisplaySelectionScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context: context),
        body: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                width: mediaQuery.size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isLargeScreen
                            ? (mediaQuery.size.width * 0.9 - 600) / 2
                            : 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0,
                            ),
                            color: const Color(0xFF8DAC9E),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home_screen/body.png',
                                  height: 40,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Body',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: mediaQuery.size.width,
                            height: 670,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width:
                                        min(mediaQuery.size.width * 0.9, 600),
                                    height: 75,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index1 + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: min(
                                              mediaQuery.size.width * 0.9 - 57,
                                              560),
                                          child: Text(
                                            '${bodyQuestions[index1]}',
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      width: mediaQuery.size.width,
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              bodyQueries[index1] =
                                                  index2.toDouble() + 1;
                                            });
                                          },
                                          child: CustomCheckBox(
                                            isSelected: bodyQueries[index1] ==
                                                index2 + 1,
                                            rebuildScreen: null,
                                            title: index2 + 1,
                                          ),
                                        ),
                                        itemCount: bodyQueries.length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: bodyQuestions.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isLargeScreen
                            ? (mediaQuery.size.width * 0.9 - 600) / 2
                            : 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0,
                            ),
                            color: const Color(0xFF8DAC9E),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home_screen/mind.png',
                                  height: 40,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Mind',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: mediaQuery.size.width,
                            height: 670,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width:
                                        min(mediaQuery.size.width * 0.9, 600),
                                    height: 75,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index1 + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: min(
                                              mediaQuery.size.width * 0.9 - 57,
                                              560),
                                          child: Text(
                                            '${mindQuestions[index1]}',
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      width: mediaQuery.size.width,
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              mindQueries[index1] =
                                                  index2.toDouble() + 1;
                                            });
                                          },
                                          child: CustomCheckBox(
                                            isSelected: mindQueries[index1] ==
                                                index2 + 1,
                                            rebuildScreen: null,
                                            title: index2 + 1,
                                          ),
                                        ),
                                        itemCount: mindQueries.length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: mindQuestions.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isLargeScreen
                            ? (mediaQuery.size.width * 0.9 - 600) / 2
                            : 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0,
                            ),
                            color: const Color(0xFF8DAC9E),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home_screen/relationships.png',
                                  height: 40,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Relationships',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: mediaQuery.size.width,
                            height: 670,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width:
                                        min(mediaQuery.size.width * 0.9, 600),
                                    height: 75,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index1 + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: min(
                                              mediaQuery.size.width * 0.9 - 57,
                                              560),
                                          child: Text(
                                            '${relationshipQuestions[index1]}',
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              relationshipQueries[index1] =
                                                  index2.toDouble() + 1;
                                            });
                                          },
                                          child: CustomCheckBox(
                                            isSelected:
                                                relationshipQueries[index1] ==
                                                    index2 + 1,
                                            rebuildScreen: null,
                                            title: index2 + 1,
                                          ),
                                        ),
                                        itemCount: relationshipQueries.length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: relationshipQuestions.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isLargeScreen
                            ? (mediaQuery.size.width * 0.9 - 600) / 2
                            : 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            color: const Color(0xFF8DAC9E),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home_screen/achievements.png',
                                  height: 40,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Achievements',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: mediaQuery.size.width,
                            height: 670,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width:
                                        min(mediaQuery.size.width * 0.9, 600),
                                    height: 75,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index1 + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: min(
                                              mediaQuery.size.width * 0.9 - 57,
                                              560),
                                          child: Text(
                                            '${achievementQuestions[index1]}',
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      width: mediaQuery.size.width,
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              achievementsQueries[index1] =
                                                  index2.toDouble() + 1;
                                            });
                                          },
                                          child: CustomCheckBox(
                                            isSelected:
                                                achievementsQueries[index1] ==
                                                    index2 + 1,
                                            rebuildScreen: null,
                                            title: index2 + 1,
                                          ),
                                        ),
                                        itemCount: achievementsQueries.length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: achievementQuestions.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isLargeScreen
                            ? (mediaQuery.size.width * 0.9 - 600) / 2
                            : 0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0,
                            ),
                            color: const Color(0xFF8DAC9E),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home_screen/personal_development.png',
                                  height: 40,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  'Personal Growth',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: mediaQuery.size.width,
                            height: 670,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width:
                                        min(mediaQuery.size.width * 0.9, 600),
                                    height: 75,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index1 + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: min(
                                              mediaQuery.size.width * 0.9 - 57,
                                              560),
                                          child: Text(
                                            '${personalGrowthQuestions[index1]}',
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      width: mediaQuery.size.width,
                                      height: 50.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              personalGrowthQueries[index1] =
                                                  index2.toDouble() + 1;
                                            });
                                          },
                                          child: CustomCheckBox(
                                            isSelected:
                                                personalGrowthQueries[index1] ==
                                                    index2 + 1,
                                            rebuildScreen: null,
                                            title: index2 + 1,
                                          ),
                                        ),
                                        itemCount: personalGrowthQueries.length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              itemCount: personalGrowthQuestions.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RaisedButton(
                      elevation: 5.0,
                      color: Color(0xFFC6D7C3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/welcome'),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 7.0,
                        ),
                        width:
                            isLargeScreen ? 400 : mediaQuery.size.width * 0.75,
                        child: Text(
                          'I Am Ready',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          nextScreen: '/pickStartDate',
        ),
      ),
    );
  }
}
