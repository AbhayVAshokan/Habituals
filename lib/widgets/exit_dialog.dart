import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> exitDialog({@required BuildContext context}) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Are you sure?',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF697c37),
            ),
          ),
          content: const Text('Do you want exit Habituals?'),
          actions: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: const Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: const Text(
                  "NO",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: const Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  right: 10.0,
                ),
                child: const Text(
                  "YES",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
