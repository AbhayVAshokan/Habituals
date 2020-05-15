// Individual cards representing each individual nudges in each category.

import 'package:flutter/material.dart';

import 'package:habituals/models/nudge.dart';

class NudgeCard extends StatelessWidget {
  final Nudge nudge;
  final String imageUrl;
  final String buttonText;

  NudgeCard({
    @required this.nudge,
    this.imageUrl,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return Container(
      height: isLargeScreen ? 80 : 40,
      width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                buttonText == null ? nudge.nudge : 'Create your own nudge',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontStyle: buttonText == null ? null : FontStyle.italic,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RaisedButton(
              color: const Color(0xFFC6D7C4),
              onPressed: () {
                if (buttonText == null)
                  Navigator.pushNamed(
                    context,
                    '/nudgeExpanded',
                    arguments: nudge,
                  );
                else
                  Navigator.pushNamed(context, '/createNudge');
              },
              child: Text(
                buttonText == null
                    ? nudge.status.compareTo('not completed') == 0
                        ? 'to be done'
                        : 'to be done'
                    : buttonText,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
