import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar myAppBar({
  @required BuildContext context,
  bool closeButton = false,
}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset('assets/images/logo_small.jpg'),
    ),
    actions: [
      closeButton
          ? IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                if (Navigator.canPop(context))
                  Navigator.pop(context);
                else
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Are you sure you want to exit?'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    ),
                  );
              },
            )
          : const SizedBox.shrink(),
    ],
  );
}
