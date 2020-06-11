// Well Being Audit Screen.

import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/memos/memo_card.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class MemosScreen extends StatefulWidget {
  static GlobalKey<AnimatedListState> _memoKey = GlobalKey<AnimatedListState>();
  @override
  _MemosScreenState createState() => _MemosScreenState();
}

class _MemosScreenState extends State<MemosScreen>
    with TickerProviderStateMixin {
  ImageFilter _imageFilter = ImageFilter.blur();

  AnimationController _transitionController1;
  Animation<double> _scaleAnimation1;
  Animation _colorAnimation1;

  AnimationController _transitionController2;
  Animation _scaleAnimation2;
  Animation _colorAnimation2;

  @override
  initState() {
    super.initState();
    menuBarHeight = 0.0;

    // Animation for page transition
    _transitionController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation1 =
        Tween<double>(begin: 1.0, end: 2000.0).animate(_transitionController1);
    _colorAnimation1 = ColorTween(
      begin: Colors.green,
      end: Colors.white,
    ).animate(_transitionController1);

    // FAB Page transition
    _transitionController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation2 =
        Tween<double>(begin: 1, end: 2000).animate(_transitionController2);
    _colorAnimation2 = ColorTween(
      begin: Colors.yellow,
      end: Colors.white,
    ).animate(_transitionController2);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    myMemos = [];
    for (int i = 0; i < memos.length; i++) {
      Timer(Duration(milliseconds: 150 * (i + 1)), () {
        myMemos.add(memos[i]);
        MemosScreen._memoKey.currentState.insertItem(i);
      });
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => exitDialog(
          context: context,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
          body: Container(
            width: mediaQuery.size.width,
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: mediaQuery.size.width,
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: isLargeScreen
                                ? 800
                                : mediaQuery.size.width * 0.9,
                            height: 75.0,
                            color: color_header_background,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                            ),
                            child: FittedBox(
                              child: Text(
                                'Your Memos',
                                style: const TextStyle(
                                  fontSize: 27.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width - 20,
                            height: 100,
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: GestureDetector(
                              // onTap: () {
                              //   setState(() {
                              //     addingListItem = true;
                              //     myMemos.add(
                              //       Container(),
                              //     );
                              //   });
                              // },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color_primary,
                                ),
                                width: 50.0,
                                height: 50.0,
                                child: Icon(
                                  Icons.add,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    memos.length == 0
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: mediaQuery.size.width * 0.6,
                                  child: Opacity(
                                    opacity: 0.75,
                                    child: Image.asset(
                                      'assets/images/memo.png',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 20.0,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: const Text(
                                      'You do not have any memos yet.\nClick to add a new memo.',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: isLargeScreen
                                    ? 800
                                    : mediaQuery.size.width * 0.9,
                                color: Colors.lightGreen[50].withOpacity(0.25),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: AnimatedList(
                                        key: MemosScreen._memoKey,
                                        itemBuilder:
                                            (context, index, animation) =>
                                                FadeTransition(
                                          opacity: animation.drive(
                                            Tween<double>(begin: 0.0, end: 1.0),
                                          ),
                                          child: SlideTransition(
                                            position: animation.drive(
                                              Tween<Offset>(
                                                begin: const Offset(-0.25, 1),
                                                end: const Offset(0, 0),
                                              ),
                                            ),
                                            child: MemoCard(
                                              memo: myMemos[index],
                                              index: index,
                                              rebuildScreen: () {
                                                // setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                BackdropFilter(
                  filter: _imageFilter,
                  child: Container(
                    width: 100,
                    height: mediaQuery.size.height,
                    color: const Color(0x00000000),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: MenuDropDown(
                    animationController: _transitionController1,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: AnimatedBuilder(
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation1.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colorAnimation1.value,
                          shape: BoxShape.circle,
                        ),
                        height: 1.0,
                        width: 1.0,
                      ),
                    ),
                    animation: _colorAnimation1,
                  ),
                ),
                Positioned(
                  top: fabOffset.dy,
                  left: fabOffset.dx,
                  child: AnimatedBuilder(
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation2.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colorAnimation2.value,
                          shape: BoxShape.circle,
                        ),
                        height: 1.0,
                        width: 1.0,
                      ),
                    ),
                    animation: _colorAnimation2,
                  ),
                ),
                Positioned(
                  top: fabOffset.dy,
                  left: fabOffset.dx,
                  child: MyFloatingActionButton(
                    rebuildScreen: () {
                      setState(() {});
                    },
                    transitionAnimationController: _transitionController2,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            forwardButton: false,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _transitionController1.dispose();
    _transitionController2.dispose();
    super.dispose();
  }
}
