import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

Future<bool> exitDialog({@required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'Are you sure?',
        style: const TextStyle(
          fontSize: 20.0,
        ),
      ),
      content: Text(
        'Do you want exit Habituals?',
        style: TextStyle(color: CupertinoColors.black.withOpacity(0.54)),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          isDefaultAction: true,
          textStyle: const TextStyle(
            color: CupertinoColors.systemPink,
          ),
          child: Text('Yes'),
        ),
        CupertinoDialogAction(
          child: Text("No"),
          onPressed: () => Navigator.of(context).pop(false),
        )
      ],
    ),
  );
}
