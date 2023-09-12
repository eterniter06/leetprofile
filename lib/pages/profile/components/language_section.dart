import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';
import 'language_card.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key, required this.languageProblemList});
  final List<LanguageSubmission> languageProblemList;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Languages',
      children: [
        SizedBox(
          height: 140,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: languageProblemList.length,
            itemBuilder: (BuildContext context, int index) => LanguageCard(
              languageDetails: languageProblemList[index],
            ),
          ),
        ),
      ],
    );
  }
}
