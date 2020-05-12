import 'package:flutter/material.dart';

import 'package:habituals/models/nudge.dart';

class NudgeCard extends StatelessWidget {
  final Nudge nudge;
  NudgeCard({@required this.nudge});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = mediaQuery.size.width >= 900;

    return Container(
      height: isLargeScreen ? 80 : 50,
      width: isLargeScreen ? 800 : mediaQuery.size.width * 0.9,
      decoration: BoxDecoration(border: Border.all()),
      // child: Row(

      //   children: [
      //     Text(''),
      //     RaisedButton(
      //       onPressed: () {},
      //       child: Text(nudge.nudge == 'not completed' ? 'to be done' : nudge.nudge == 'completed'),
      //     ),
      //   ],
      // ),
      child: Text('hello wordl'),
    );
  }
}
