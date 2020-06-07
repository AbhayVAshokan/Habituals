import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../resources/constants.dart';

class NudgeCard extends StatelessWidget {
  final Nudge nudge;
  NudgeCard({@required this.nudge});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: color_accent,
              border: Border.all(width: 2.0),
            ),
            child: Icon(
              nudge.status == 'not completed'
                  ? Icons.close
                  : nudge.status == 'completed'
                      ? Icons.check
                      : Icons.subdirectory_arrow_right,
              size: 35.0,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              child: Text(
                nudge.nudge,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
