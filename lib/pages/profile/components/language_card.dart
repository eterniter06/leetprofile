import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.languageDetails,
  });
  final LanguageSubmission languageDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: AspectRatio(
        aspectRatio: 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    languageDetails.problemsSolved.toString(),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  heightFactor: 1,
                  child: Text(
                    languageDetails.languageName!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
