import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.badges});
  final List<UserBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const Text('Badges'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int index = 0; index < badges.length; ++index) ...{
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Image.network(
                              badges[index].iconLink!,
                              scale: 4,
                            ),
                            Wrap(children: [
                              Text(
                                badges[index].displayName!,
                                softWrap: true,
                              ),
                            ])
                          ],
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
      ),
    );
  }
}
