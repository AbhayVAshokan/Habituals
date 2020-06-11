// Individual card for representing individual categories in the nudge screen.

import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../resources/constants.dart';
import '../../widgets/well_being_nudges/nudge_card.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final String type;

  CategoryCard({
    @required this.category,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width >= 900;

    List<Nudge> pendingNudges = type == 'today'
        ? category['nudges']
            .where(
              (Nudge _nudge) => (_nudge.date.day == DateTime.now().day &&
                  _nudge.date.month == DateTime.now().month &&
                  _nudge.date.year == DateTime.now().year &&
                  _nudge.status == 'not completed'),
            )
            .toList()
        : category['nudges']
            .where(
              (Nudge _nudge) => ((_nudge.date.day >= DateTime.now().day &&
                      _nudge.date.day <=
                          DateTime.now().add(Duration(days: 7)).day) &&
                  (_nudge.date.month >= DateTime.now().month &&
                      _nudge.date.month <=
                          DateTime.now().add(Duration(days: 7)).month) &&
                  (_nudge.date.year >= DateTime.now().year &&
                      _nudge.date.year <=
                          DateTime.now().add(Duration(days: 7)).year) &&
                  _nudge.status == 'not completed'),
            )
            .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
          tag: '${category['category'].toUpperCase()}_container',
          flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) =>
              DefaultTextStyle(
            style: DefaultTextStyle.of(toHeroContext).style,
            child: toHeroContext.widget,
          ),
          child: Container(
            color: color_primary,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            height: isLargeScreen ? 80 : 60,
            child: SizedBox(
              width: min(mediaQuery.size.width * 0.9, 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    category['imageUrl'],
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${category['category'].toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: pendingNudges.length.toDouble() * (isLargeScreen ? 85 : 45),
          margin: const EdgeInsets.only(
            top: 5.0,
          ),
          child: pendingNudges.length == 0
              ? Container(
                  child: Text(
                    'No pending nudges',
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => NudgeCard(
                    nudge: pendingNudges[index],
                    imageUrl: category['imageUrl'],
                    color: category['color'],
                  ),
                  itemCount: pendingNudges.length,
                ),
        ),
        NudgeCard(
          nudge: null,
          buttonText: 'Status',
          color: category['color'],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
