// Custom Tab Bar

import 'package:flutter/material.dart';

Widget myTabBar({@required String screen}) {
  List<Tab> tabs = [
    const Tab(
      child: const Text(
        'Today',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    const Tab(
      child: const Text(
        '7 Days',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ];

  if (screen == 'journey')
    tabs.add(
      const Tab(
        child: const Text(
          '66 Days',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );

  return Container(
    alignment: Alignment.centerLeft,
    width: screen == 'audit' ? 175.0 : 300,
    child: TabBar(
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      tabs: tabs,
    ),
  );
}
