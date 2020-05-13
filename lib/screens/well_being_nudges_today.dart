// Well being nudges for the current day.

import 'package:flutter/material.dart';

import '../widgets/nudges/category_card.dart';

class WellBeingNudgesToday extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  WellBeingNudgesToday({@required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                itemBuilder: (context, index) => CategoryCard(
                  category: categories[index],
                ),
                itemCount: categories.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
