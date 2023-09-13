import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.link,
    required this.icon,
    required this.socialMedia,
    this.color,
  });

  final IconData icon;
  final String link;
  final String socialMedia;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Launch $socialMedia profile",
      onPressed: () async {
        Uri link = Uri.parse(this.link);
        if (await canLaunchUrl(link) == true) {
          launchUrl(link, mode: LaunchMode.externalApplication);
        } else {
          throw "Unable to launch $socialMedia profile page. Perhaps the profile link is outdated.";
        }
      },
      icon: FaIcon(
        icon,
        semanticLabel: "$socialMedia profile",
        color: color,
        size: 36,
      ),
    );
  }
}
