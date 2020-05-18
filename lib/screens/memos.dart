// Well Being Audit Screen.

import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/memos/memo_card.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class Memos extends StatefulWidget {
  @override
  _MemosState createState() => _MemosState();
}

class _MemosState extends State<Memos> with TickerProviderStateMixin {
  GlobalKey<AnimatedListState> _globalKey = GlobalKey<AnimatedListState>();
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

    for (int i = 0; i < memos.length; i++) {
      Timer(Duration(milliseconds: 150 * (i + 1)), () {
        insertIntoList(memo: memos[i]);
      });
    }

    myMemos = [];
  }

  insertIntoList({@required memo, int position}) {
    myMemos.insert(
      position == null ? myMemos.length : position,
      memo,
    );
    _globalKey.currentState.insertItem(
        position == null ? myMemos.length - 1 : position,
        duration: const Duration(milliseconds: 300));
  }

  deleteFromList() {
    _globalKey.currentState.removeItem(
      9,
      (context, animation) => FadeTransition(
        opacity: Tween(begin: 1.0, end: 0.0).animate(animation),
        child: SlideTransition(
          position: Tween(
            begin: Offset(0, 0),
            end: Offset(0, -1),
          ).animate(animation),
        ),
      ),
      duration: const Duration(seconds: 2),
    );
    // myMemos.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    print(myMemos);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

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
                          SizedBox(
                            width: isLargeScreen
                                ? 800
                                : mediaQuery.size.width * 0.9,
                            height: 75.0,
                            child: Container(
                              color: Colors.yellow[300],
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
                          ),
                          SizedBox(
                            width: mediaQuery.size.width - 20,
                            height: 100,
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  addingListItem = true;
                                  insertIntoList(
                                    memo: Container(),
                                    position: 0,
                                  );
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF4C7160),
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
                                          'assets/images/memo.png')),
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
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                width: isLargeScreen
                                    ? 800
                                    : mediaQuery.size.width * 0.9,
                                color: Colors.blueGrey[50],
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: AnimatedList(
                                        key: _globalKey,
                                        itemBuilder:
                                            (context, index, animation) =>
                                                FadeTransition(
                                          opacity: Tween(begin: 0.0, end: 1.0)
                                              .animate(animation),
                                          child: SlideTransition(
                                            position: animation.drive(
                                              Tween(
                                                begin: Offset(-0.25, 0),
                                                end: Offset(0, 0),
                                              ),
                                            ),
                                            child: MemoCard(
                                              memo: myMemos[index],
                                              insertIntoList: insertIntoList,
                                              deleteFromList: deleteFromList,
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
