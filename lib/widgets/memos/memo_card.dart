import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../models/memo.dart';
import '../../resources/realtime_data.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;
  final int index;
  final Function rebuildScreen;

  MemoCard({
    @required this.memo,
    @required this.index,
    @required this.rebuildScreen,
  });
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (removedMemo) {
        memos.removeAt(index);
        print(memos.length);
        rebuildScreen();
      },
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF9a1f40),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            const Text(
              'Delete memo',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 120.0,
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        memo.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      DateFormat("dd MMM").format(memo.date),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.blueGrey,
                        fontFamily: 'default',
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 57.0,
                  child: Text(
                    memo.data,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      letterSpacing: 0.5,
                      fontFamily: 'default',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
