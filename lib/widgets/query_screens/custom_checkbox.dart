// Custom checkbox for the query screens.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final int title;
  final String subtitle;
  final bool isSelected;
  final Function rebuildScreen;

  CustomCheckBox({
    @required this.title,
    @required this.isSelected,
    @required this.rebuildScreen,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;
    return GestureDetector(
      onTap: rebuildScreen,
      child: Container(
        height: isLargeScreen ? 100.0 : 80.0,
        width: isLargeScreen ? 100.0 : 60.0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 14.0,
              child: FittedBox(
                child: Text(
                  title.toString(),
                  style: const TextStyle(fontSize: 13.0),
                ),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xAA8DAC9E),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.lightGreen[800] : Colors.white,
                ),
              ),
            ),
            subtitle != null
                ? Container(
                    height: isLargeScreen ? 50.0 : 30.0,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      subtitle,
                      maxLines: subtitle == 'Indifferent' ? 1 : 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isLargeScreen ? 15.0 : 12.0,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
