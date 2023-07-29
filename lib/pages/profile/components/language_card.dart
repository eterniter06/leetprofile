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
        aspectRatio: 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    languageDetails.languageName!,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Center(
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        languageDetails.problemsSolved.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
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
