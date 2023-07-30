import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.badges});
  final List<UserBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8.0),
              child: const Text('Badges'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int index = 0; index < badges.length; ++index) ...{
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: min(
                                  MediaQuery.of(context).size.width / 4, 160),
                              child: Image.network(
                                badges[index].iconLink!,
                              ),
                            ),
                            SizedBox(
                              width: min(
                                  MediaQuery.of(context).size.width / 4, 160),
                              height: 60,
                              child: Center(
                                child: Wrap(children: [
                                  Text(
                                    badges[index].displayName!,
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  }
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
