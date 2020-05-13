// Custom Tab Bar

import 'package:flutter/material.dart';

Widget myTabBar() {
  return Container(
    alignment: Alignment.centerLeft,
    width: 175.0,
    child: TabBar(
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      tabs: [
        Tab(
          child: Text(
            'Today',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Tab(
          child: Text(
            '7 Days',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
