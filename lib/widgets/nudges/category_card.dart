// Individual card for representing individual categories in the nudge screen.

import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../widgets/nudges/nudge_card.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width >= 900;

    List<Nudge> pendingNudges = category['nudges'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFF4C7160),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          height: isLargeScreen ? 80 : 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                category['imageUrl'],
                fit: BoxFit.cover,
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(
                width: min(mediaQuery.size.width * 0.9, 800) - 70,
                child: Text(
                  '${category['category'].toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: pendingNudges.length.toDouble() * (isLargeScreen ? 85 : 45),
          margin: const EdgeInsets.only(
            top: 5.0,
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                NudgeCard(nudge1temp: pendingNudges[index], imageUrl: category['imageUrl'],),
            itemCount: pendingNudges.length,
          ),
        ),
        NudgeCard(
          nudge1temp: null,
          buttonText: 'Status',
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
