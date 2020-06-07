// Well Being Audit Screen.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import '../widgets/my_appbar.dart';
import '../resources/constants.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/menu_dropdown.dart';
import '../resources/realtime_data.dart';
import '../widgets/memos/memo_card.dart';
import '../widgets/my_bottom_navbar.dart';
import '../widgets/my_floating_action_button.dart';

class MemosScreen extends StatefulWidget {
  @override
  _MemosScreenState createState() => _MemosScreenState();
}

class _MemosScreenState extends State<MemosScreen>
    with TickerProviderStateMixin {
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

    // myMemos = [];

    // for (int i = 0; i < memos.length; i++) {
    //   Timer(Duration(milliseconds: 150 * (i + 1)), () {
    //     myMemos.add(memos[i]);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    memos.forEach((element) {
      print(element.id);
    });

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
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                width: isLargeScreen
                                    ? 800
                                    : mediaQuery.size.width * 0.9,
                                color: Colors.grey[100],
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ImplicitlyAnimatedReorderableList(
                                          key: _globalKey,
                                          items: memos,
                                          areItemsTheSame: (oldItem, newItem) =>
                                              oldItem.id == newItem.id,
                                          onReorderFinished:
                                              (item, from, to, newItems) {
                                            // Remember to update the underlying data when the list has been
                                            // reordered.
                                            setState(() {
                                              memos
                                                ..clear()
                                                ..addAll(newItems);
                                            });
                                          },
                                          itemBuilder: (context, itemAnimation,
                                              item, index) {
                                            // Each item must be wrapped in a Reorderable widget.
                                            return Reorderable(
                                              // Each item must have an unique key.
                                              key: ValueKey(item),
                                              // The animation of the Reorderable builder can be used to
                                              // change to appearance of the item between dragged and normal
                                              // state. For example to add elevation when the item is being dragged.
                                              // This is not to be confused with the animation of the itemBuilder.
                                              // Implicit animations (like AnimatedContainer) are sadly not yet supported.
                                              builder: (context, dragAnimation,
                                                  inDrag) {
                                                final t = dragAnimation.value;
                                                final elevation =
                                                    lerpDouble(0, 8, t);
                                                final color = Color.lerp(
                                                    Colors.white,
                                                    Colors.white
                                                        .withOpacity(0.8),
                                                    t);

                                                return SizeFadeTransition(
                                                  sizeFraction: 0.7,
                                                  curve: Curves.easeInOut,
                                                  animation: itemAnimation,
                                                  child: MemoCard(
                                                    index: index,
                                                    rebuildScreen: () {
                                                      setState(() {});
                                                    },
                                                    memo: memos[index],
                                                  ),
                                                );
                                              },
                                            );
                                          }),
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
