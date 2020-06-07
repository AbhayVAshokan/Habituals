// Custom App Bar

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/realtime_data.dart';

AppBar myAppBar({
  @required BuildContext context,
  bool closeButton = false,
  bool menuButton = false,
  Function rebuildScreen,
  bottom,
}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Hero(
        tag: 'logo',
        child: Image.asset('assets/images/logo_small.jpg'),
      ),
    ),
    actions: [
      menuButton
          ? IconButton(
              padding: const EdgeInsets.all(20.0),
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                menuBarHeight = menuBarHeight > 0
                    ? 0
                    : MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 345
                        : 295;
                rebuildScreen();
              },
            )
          : SizedBox.shrink(),
      closeButton
          ? IconButton(
              padding: const EdgeInsets.all(20.0),
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
    bottom: bottom,
  );
}
