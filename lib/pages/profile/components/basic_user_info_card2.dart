import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/change_notifiers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/circular_network.dart';
import 'package:ui_elements/interfaces.dart';
import 'social_media_button.dart';

class BasicInfoExp extends StatelessWidget implements ClassName {
  const BasicInfoExp({
    super.key,
    required this.userData,
  });

  final UserData userData;
  final EdgeInsets widgetPadding = const EdgeInsets.symmetric(horizontal: 28);

  String displayName() {
    return userData.realname.isNotEmpty
        ? userData.realname
        : userData.nickname ?? userData.username;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: widgetPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircularNetworkImage(
                    radius: 80,
                    imageLink: userData.avatar,
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName(),
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData.username,
                          style: const TextStyle(
                            fontSize: 16,
                            color: ThemeModeModel.lightSecondaryInverse,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Ranking: ${userData.ranking}'),
                        Text('Reputation: ${userData.reputation}'),
                        Text('Solutions: ${userData.solutionCount}'),
                        Text('Views: ${userData.postViewCount}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 16),
            if (userData.githubUrl != null || userData.linkedinUrl != null) ...[
              Padding(
                padding: widgetPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    if (userData.githubUrl != null) ...[
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
                      ),
                    ],
                  ],
                ),
              ),
            ] else
              Padding(
                padding: widgetPadding,
                child: Text('${displayName()} has no links'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  String className() {
    return 'BasicUserInfo';
  }
}

// if (userData.githubUrl != null ||
//                           userData.linkedinUrl != null) ...[
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             if (userData.linkedinUrl != null) ...[
//                               SocialMediaButton(
//                                 icon: FontAwesomeIcons.linkedin,
//                                 link: userData.linkedinUrl!,
//                                 color: const Color(0xff0077b5),
//                                 socialMedia: 'Linkedin',
//                               ),
//                               const SizedBox(width: 8),
//                             ],
//                             if (userData.githubUrl != null)
//                               Consumer<ThemeModeModel>(
//                                 builder: (context, themeModel, child) =>
//                                     SocialMediaButton(
//                                   icon: FontAwesomeIcons.github,
//                                   link: userData.githubUrl!,

//                                   // color: const Color(0xff171515),
//                                   // Workaround so that github logo is visible against dark background
//                                   // Check to see if logo color and background can be adjusted
//                                   color: themeModel.themeMode ==
//                                           ThemeMode.system
//                                       ? MediaQuery.of(context)
//                                                   .platformBrightness ==
//                                               Brightness.dark
//                                           ? const Color(0xffffffff)
//                                           : const Color(0xff171515)
//                                       : themeModel.themeMode == ThemeMode.dark
//                                           ? const Color(0xffffffff)
//                                           : const Color(0xff171515),
//                                   socialMedia: 'Github',
//                                 ),
//                               )
//                           ],
//                         )
//                       ],