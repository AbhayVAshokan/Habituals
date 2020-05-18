import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:habituals/resources/privacy_policy.dart';
import 'package:habituals/resources/terms_of_service.dart';
import 'package:intl/intl.dart';

import '../resources/custom_icons.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_bottom_navbar.dart';

class PrivacyPolicyTOS extends StatelessWidget {
  final int initialIndex;
  PrivacyPolicyTOS({
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: initialIndex,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[100],
          appBar: myAppBar(
            context: context,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    CustomIcons.termsOfService,
                    color: const Color(0xFF4C7160),
                    size: 30.0,
                  ),
                ),
                Tab(
                  icon: Icon(
                    CustomIcons.privacyPolicy,
                    color: const Color(0xFF4C7160),
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.blueGrey[200],
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: const Text(
                                'Terms of Service',
                                style: const TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Last updated: ${DateFormat("dd MMM, yyyy").format(lastUpdated)}',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        child: Container(
                          color: Colors.blueGrey[100],
                          child: Markdown(
                            selectable: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 20.0,
                            ),
                            data: termsOfService,
                            styleSheetTheme:
                                MarkdownStyleSheetBaseTheme.cupertino,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.blueGrey[200],
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Privacy Policy',
                              style: const TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Last updated: ${DateFormat("dd MMM, yyyy").format(lastUpdated)}',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        child: Container(
                          color: Colors.blueGrey[100],
                          child: Markdown(
                            selectable: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 20.0,
                            ),
                            data: privacyPolicy,
                            styleSheetTheme:
                                MarkdownStyleSheetBaseTheme.cupertino,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            forwardButton: false,
          ),
        ),
      ),
    );
  }
}
