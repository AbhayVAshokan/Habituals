// Form asking for feedback for why the user skipped the nudge.

import 'package:flutter/material.dart';

class SkipNudge extends StatelessWidget {
  final double _containerOpacity;
  SkipNudge(this._containerOpacity);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeIn,
      opacity: _containerOpacity,
      child: Container(
        width: 250.0,
        height: 100.0,
        decoration: BoxDecoration(color: Colors.white, border: Border.all()),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please let us know why you skipped the nudge'),
            SizedBox(
              height: 20.0,
              child: TextField(
                cursorColor: Colors.lightGreen,
                enabled: _containerOpacity == 0 ? false : true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
