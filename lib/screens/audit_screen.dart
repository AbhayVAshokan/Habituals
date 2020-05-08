import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class AuditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> categoryData =
        ModalRoute.of(context).settings.arguments;
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          menuButton: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.075),
              Container(
                color: Color(0xFFC6D7C4),
                width: min(mediaQuery.size.width * 0.9, 800),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Image.asset(
                        categoryData['imageUrl'],
                        height: 50.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '${categoryData['category'].toUpperCase() + ' AUDIT'}',
                            style: const TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50.0),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 30.0,
                  ),
                  child: LayoutBuilder(
                    builder: (context, parentConstraints) => ListView.builder(
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        height: min(
                            (parentConstraints.maxHeight - 60) /
                                categoryData['data'].length,
                            75),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius:
                                      min(constraints.maxWidth * 0.06, 20.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Color(0xFF4C7160),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth - 120.0,
                                child: Text(
                                  categoryData['questions'][index],
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                width: 40.0,
                                height: 40.0,
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF8DAC9E),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    categoryData['data'][index].toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemCount: categoryData['data'].length,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: myBottomNavbar(context: context),
      ),
    );
  }
}
