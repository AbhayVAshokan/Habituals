// Well being journey for the current day

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../resources/realtime_data.dart';
import '../widgets/well_being_journey/nudge_card.dart';

class WellBeingJourneyToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 5.0,
            ),
            child: Text(
              DateFormat('dd|MM|yyyy').format(
                DateTime.now(),
              ),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                color: const Color(0xFFC6D7C4),
                child: const Text(
                  'Dimension',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.share,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    NudgeCard(nudge: allNudgesToday[index]),
                itemCount: allNudgesToday.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
