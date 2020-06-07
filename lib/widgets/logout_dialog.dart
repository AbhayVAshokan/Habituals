import 'package:flutter/cupertino.dart';

Future<bool> logoutDialog({@required BuildContext context}) {
  return showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'Are you sure?',
        style: const TextStyle(
          fontSize: 20.0,
        ),
      ),
      content: Text(
        'Do you want logout from Habituals?',
        style: TextStyle(color: CupertinoColors.black.withOpacity(0.54)),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
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
