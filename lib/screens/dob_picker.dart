import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class DobPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(context: context),
        body: Center(
          child: Text('End of app as of now!!!'),
        ),
        bottomNavigationBar: myBottomNavbar(context: context),
      ),
    );
  }
}
