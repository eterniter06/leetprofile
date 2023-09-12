import 'dart:math';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/circular_network.dart';
import 'social_media_button.dart';

class BasicUserInfo extends StatelessWidget {
  const BasicUserInfo({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Text('Basic Info'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircularNetworkImage(
                      radius: 80,
                      imageLink: userData.avatar,
                    ),
                    Text(userData.username),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.realname,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 16),
                    Text('Ranking: ${userData.ranking}'),
                    Text('Reputation: ${userData.reputation}'),
                    Text('Solutions: ${userData.solutionCount}'),
                    Text('Views: ${userData.postViewCount}'),
                    if (userData.githubUrl != null ||
                        userData.linkedinUrl != null) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userData.linkedinUrl != null) ...[
                            SocialMediaButton(
                              icon: FontAwesomeIcons.linkedin,
                              link: userData.linkedinUrl!,
                              color: const Color(0xff0077b5),
                              socialMedia: 'Linkedin',
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (userData.githubUrl != null)
                            SocialMediaButton(
                              icon: FontAwesomeIcons.github,
                              link: userData.githubUrl!,
                              // color: const Color(0xff171515),
                              // Workaround so that github logo is visible against dark background
                              // Check to see if logo color and background can be adjusted
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? const Color(0xffffffff)
                                      : const Color(0xff171515),
                              socialMedia: 'Github',
                            )
                        ],
                      )
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
