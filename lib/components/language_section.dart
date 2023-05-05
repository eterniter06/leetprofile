import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';
import 'language_card.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection(
      {super.key,
      required this.languageProblemList,
      required this.valueScaler});
  final List<LanguageSubmission> languageProblemList;
  final Function valueScaler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: valueScaler(context, 140),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: languageProblemList.length,
        itemBuilder: (BuildContext context, int index) => LanguageCard(
          languageDetails: languageProblemList[index],
          valueScaler: valueScaler,
        ),
      ),
    );
  }
}