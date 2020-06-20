// Custom Tab Bar

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habituals/resources/constants.dart';

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
      child: AutoSizeText(
        '7 Days',
        maxLines: 1,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ];

  if (screen == 'journey')
    tabs.add(
      const Tab(
        child: const AutoSizeText(
          '66 Days',
          maxLines: 1,
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
      indicatorColor: color_body,
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
