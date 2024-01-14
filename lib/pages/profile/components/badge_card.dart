import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';
import 'package:ui_elements/pages/profile/components/trailing_scroll_button.dart';

class BadgeCard extends StatefulWidget implements ClassName {
  const BadgeCard({super.key, required this.badges});
  final List<UserBadge> badges;

  @override
  State<BadgeCard> createState() => _BadgeCardState();

  @override
  String className() {
    return 'BadgeCard';
  }
}

class _BadgeCardState extends State<BadgeCard> {
  bool isScrollable = false;

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.position.maxScrollExtent > 0) {
        setState(() {
          isScrollable = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      header: 'Badges',
      trailer: isScrollable
          ? TrailingScrollButton(scrollController: scrollController)
          : null,
      children: [
        SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int index = 0; index < widget.badges.length; ++index) ...{
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: min(MediaQuery.of(context).size.width / 4, 160),
                        child: BadgeIcon(
                            badgeLink: widget.badges[index].iconLink!),
                      ),
                      SizedBox(
                        width: min(MediaQuery.of(context).size.width / 4, 160),
                        height: 60,
                        child: Center(
                          child: Wrap(children: [
                            Text(
                              widget.badges[index].displayName!,
                              softWrap: true,
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              }
            ],
          ),
        ),
      ],
    );
  }
}

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    super.key,
    required this.badgeLink,
  });

  final String badgeLink;

  @override
  Widget build(BuildContext context) {
    return badgeLink.contains('http')
        ? CachedNetworkImage(
            imageUrl: badgeLink,
            // Todo: Find a placeholder badge icon
            // placeholder: (context, url) => AssetImage(asset: 'asset/'),
          )
        : Image.asset(badgeLink);
  }
}
