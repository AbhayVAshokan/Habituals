import 'package:flutter/material.dart';

nextPage(BuildContext context, String nextScreen) {
  Navigator.pushNamed(context, nextScreen);
}

Widget myBottomNavbar({
  @required BuildContext context,
  String nextScreen,
  bool forwardButton = true,
  bool backButton = true,
}) {
  return Container(
    height: 60.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        backButton
            ? IconButton(
                padding: const EdgeInsets.all(5.0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 28.0,
                ),
              )
            : SizedBox.shrink(),
        forwardButton
            ? IconButton(
                padding: const EdgeInsets.all(5.0),
                onPressed: () => nextPage(context, nextScreen),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 28.0,
                ),
              )
            : SizedBox.shrink(),
      ],
    ),
  );
}
