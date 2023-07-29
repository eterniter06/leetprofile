import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.badges});
  final List<String> badges;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int index = 0; index < badges.length; ++index) ...{
                  Image.network(
                    badges[index],
                    scale: 4,
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
