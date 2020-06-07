// Progress bar indicating page number in the query screens.

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentIndex;
  final int totalIndex;
  final Color color;

  ProgressBar({
    @required this.color,
    @required this.currentIndex,
    @required this.totalIndex,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return Container(
      width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
      height: 30.0,
      margin: EdgeInsets.only(
        bottom: mediaQuery.size.height * 0.05,
      ),
      child: Row(
        children: [
          for (int i = 0; i < totalIndex; i++)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  color: i <= currentIndex
                      ? color.withOpacity(0.25)
                      : Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}
