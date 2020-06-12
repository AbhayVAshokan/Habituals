// Well Being Journey for 7 Days.

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../resources/constants.dart';
import '../widgets/well_being_journey/nudge_chart_7days.dart';

class WellBeingJourney7Days extends StatelessWidget {
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
                color: color_accent,
                child: const FittedBox(
                  child: const Text(
                    'Dimension',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.file_download,
                      size: 30.0,
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
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: NudgeChart7Days(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          {
                            'label': 'done',
                            'color': Colors.green,
                          },
                          {
                            'label': 'not done',
                            'color': Colors.yellow,
                          },
                          {
                            'label': 'skipped',
                            'color': Colors.red,
                          },
                        ]
                            .map(
                              (bar) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40.0,
                                      height: 10.0,
                                      color: bar['color'],
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      bar['label'],
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5.0),
                            width: 40.0,
                            height: 2.0,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            'Well Being Pulse',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
