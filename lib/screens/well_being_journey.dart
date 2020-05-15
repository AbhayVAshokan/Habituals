// Well Being Journey screen.

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_tabbar.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/my_bottom_navbar.dart';
import '../screens/well_being_journey_7days.dart';
import '../screens/well_being_journey_today.dart';
import '../screens/well_being_journey_66days.dart';

class WellBeingJourney extends StatefulWidget {
  @override
  _WellBeingJourneyState createState() => _WellBeingJourneyState();
}

class _WellBeingJourneyState extends State<WellBeingJourney> {
  double _containerHeight = 0;
  ImageFilter _imageFilter = ImageFilter.blur();

  @override
  void initState() {
    menuBarHeight = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => exitDialog(context: context),
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
                child: SizedBox(
                  width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                  child: Stack(
                    children: [
                      DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 90.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: myTabBar(screen: 'journey'),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  WellBeingJourneyToday(),
                                  WellBeingJourney7Days(),
                                  WellBeingJourney66Days(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BackdropFilter(
                        filter: _imageFilter,
                        child: Container(
                          width: 100,
                          height: mediaQuery.size.height,
                          color: const Color(0x0000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _imageFilter = _containerHeight == 180.0
                                ? ImageFilter.blur()
                                : ImageFilter.blur(
                                    sigmaX: 2.0,
                                    sigmaY: 2.0,
                                  );
                            _containerHeight =
                                _containerHeight == 180.0 ? 0.0 : 180.0;
                          });
                        },
                        child: SizedBox(
                          width:
                              isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
                          child: Column(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag: 'heading',
                                      flightShuttleBuilder: (flightContext,
                                              animation,
                                              flightDirection,
                                              fromHeroContext,
                                              toHeroContext) =>
                                          DefaultTextStyle(
                                        style:
                                            DefaultTextStyle.of(toHeroContext)
                                                .style,
                                        child: toHeroContext.widget,
                                      ),
                                      child: Container(
                                        color: Colors.yellow[300],
                                        width: isLargeScreen
                                            ? 800
                                            : mediaQuery.size.width * 0.9,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            'Well-Being Journey',
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
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
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.decelerate,
                                color: Colors.yellow[300],
                                height: _containerHeight,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 20.0,
                                ),
                                child: const Text(
                                  'The Well-Being Journey shows you your progress in the Corporate Well-Being over time. In the dashboard you can choose a \"Today\", \"7 Days\" and \"66 Days\" time frame, as well as Dimension. Check the status of your nudges and see what impact it has on your Well-Being Pulse!',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: MenuDropDown(),
              ),
            ],
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            forwardButton: false,
          ),
        ),
      ),
    );
  }
}
