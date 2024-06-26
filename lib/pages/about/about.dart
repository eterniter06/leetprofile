import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/common_components/widgets/circular_image.dart';
import 'package:ui_elements/main.dart';
import 'package:ui_elements/providers/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class StaticLinks {
  static const String author = 'eterniter06';
  static const String authorGithubProfileLink = 'https://github.com/$author';
  static const String appGithubRepoLink =
      '$authorGithubProfileLink/leetprofile';
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 84, left: 40, right: 40, bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Required to prevent the image from stretching: https://api.flutter.dev/flutter/widgets/SizedBox-class.html
            Center(
              child: CircularImage(
                imageLink: 'assets/ic_launcher-playstore.png',
                radius: MediaQuery.of(context).size.height / 20,
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'LeetProfile',
                style:
                    TextStyle(fontSize: 20, color: ThemeModeModel.lightPrimary),
              ),
            ),
            Center(
                child: Text(Provider.of<AppInfoProvider>(context, listen: false)
                    .packageInfo
                    .version)),
            const SizedBox(height: 40),
            Text.rich(
              TextSpan(
                text:
                    'A simple app for viewing leetcode profiles.\n\nFor bug reports and feature requests, please visit the app repo on github: ',
                children: [
                  TextSpan(
                    text: StaticLinks.appGithubRepoLink,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => launchLink(
                            link: StaticLinks.appGithubRepoLink,
                            errorMessage:
                                'Could not open link to the repository.',
                          ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox(height: 40)),
            Center(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => launchLink(
                  link: StaticLinks.authorGithubProfileLink,
                  errorMessage: "Failed to open Profile link.",
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<ThemeModeModel>(
                        builder: (context, themeModel, child) => FaIcon(
                          FontAwesomeIcons.github,
                          size: 36,
                          color: themeModel.equivalentThemeMode(
                                      MediaQuery.platformBrightnessOf(
                                          context)) ==
                                  ThemeMode.light
                              ? const Color(0xff171515)
                              : const Color(0xffffffff),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(StaticLinks.author),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchLink({required String link, String? errorMessage}) async {
    errorMessage ??= 'Unable to launch link: $link';

    Uri linkUri = Uri.parse(link);

    if (await canLaunchUrl(linkUri) == true) {
      launchUrl(linkUri, mode: LaunchMode.externalApplication);
    } else {
      throw errorMessage;
    }
  }
}
