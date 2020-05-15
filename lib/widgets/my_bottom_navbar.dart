// Custom bottom navigation bar

import 'package:flutter/material.dart';

import './exit_dialog.dart';

nextPage(BuildContext context, String nextScreen) {
  Navigator.pushNamed(context, nextScreen);
}

Widget myBottomNavbar({
  @required BuildContext context,
  String nextScreen,
  bool forwardButton = true,
  bool backButton = true,
}) {
  bool isLargeScreen = MediaQuery.of(context).size.width >= 900;

  return Container(
    height: 60.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        backButton
            ? IconButton(
                padding: const EdgeInsets.all(5.0),
                onPressed: () {
                  if (Navigator.canPop(context))
                    Navigator.pop(context);
                  else
                    exitDialog(context: context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: isLargeScreen ? 40.0 : 28.0,
                ),
              )
            : SizedBox.shrink(),
        forwardButton
            ? IconButton(
                padding: const EdgeInsets.all(5.0),
                onPressed: () => nextPage(context, nextScreen),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: isLargeScreen ? 40.0 : 28.0,
                ),
              )
            : SizedBox.shrink(),
      ],
    ),
  );
}
