import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habituals/resources/realtime_data.dart';
import 'package:habituals/widgets/menu_dropdown.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class AuditScreen extends StatefulWidget {
  @override
  _AuditScreenState createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> categoryData =
        ModalRoute.of(context).settings.arguments;
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
          rebuildScreen: () {
            setState(() {
              _imageFilter = menuBarHeight > 0 && !isLargeScreen
                  ? ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    )
                  : ImageFilter.blur();
            });
          },
        ),
        body: Stack(
          children: [
            Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 70.0),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, parentConstraints) => Container(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 30.0,
                            ),
                            width: min(mediaQuery.size.width * 0.9, 800),
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                height: isLargeScreen ? 100 : 75,
                                child: LayoutBuilder(
                                  builder: (context, constraints) => Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircleAvatar(
                                          radius: min(
                                              constraints.maxWidth * 0.06,
                                              20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: Color(0xFF4C7160),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth - 120.0,
                                        child: Text(
                                          categoryData['questions'][index],
                                          style: TextStyle(
                                            fontSize:
                                                isLargeScreen ? 18.0 : 15.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5.0),
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xFF8DAC9E),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Text(
                                            categoryData['data'][index]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: categoryData['data'].length,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  BackdropFilter(
                    filter: _imageFilter,
                    child: Container(
                      width: 100,
                      height: mediaQuery.size.height,
                      color: const Color(0x000000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imageFilter = _containerHeight == 130.0
                            ? ImageFilter.blur()
                            : ImageFilter.blur(
                                sigmaX: 2.0,
                                sigmaY: 2.0,
                              );
                        _containerHeight =
                            _containerHeight == 130 ? 0.0 : 130.0;
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Color(0xFFC6D7C4),
                              width: min(mediaQuery.size.width * 0.9, 800),
                              height: 70.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    categoryData['imageUrl'],
                                    height: 50.0,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          '${categoryData['category'].toUpperCase() + ' AUDIT'}',
                                          style: const TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50.0),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -10.0,
                              right: -10.0,
                              child: IconButton(
                                icon: Transform.rotate(
                                  angle: -pi / 2,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.blueGrey,
                                    size: 20.0,
                                  ),
                                ),
                                onPressed: null,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate,
                          color: Color(0xFFC6D7C4),
                          width: min(mediaQuery.size.width * 0.9, 800),
                          height: _containerHeight,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          child: Text(
                            categoryData['instructions'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: MenuDropDown(),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(context: context),
      ),
    );
  }
}
