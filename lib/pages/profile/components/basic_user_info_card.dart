import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/change_notifiers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/circular_network.dart';
import 'package:ui_elements/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';
import 'social_media_button.dart';

class BasicUserInfo extends StatelessWidget implements ClassName {
  const BasicUserInfo({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Basic Info',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircularNetworkImage(
                  radius: 80,
                  imageLink: userData.avatar,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  userData.username,
                  style: const TextStyle(
                    color: ThemeModeModel.lightSecondaryInverse,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.realname,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ThemeModeModel.lightSecondaryInverse,
                  ),
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
                        Consumer<ThemeModeModel>(
                          builder: (context, themeModel, child) =>
                              SocialMediaButton(
                            icon: FontAwesomeIcons.github,
                            link: userData.githubUrl!,

                            // color: const Color(0xff171515),
                            // Workaround so that github logo is visible against dark background
                            // Check to see if logo color and background can be adjusted
                            color: themeModel.themeMode == ThemeMode.system
                                ? MediaQuery.of(context).platformBrightness ==
                                        Brightness.dark
                                    ? const Color(0xffffffff)
                                    : const Color(0xff171515)
                                : themeModel.themeMode == ThemeMode.dark
                                    ? const Color(0xffffffff)
                                    : const Color(0xff171515),
                            socialMedia: 'Github',
                          ),
                        )
                    ],
                  )
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  String className() {
    return 'BasicUserInfo';
  }
}
