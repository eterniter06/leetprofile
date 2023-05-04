import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(
      {super.key, required this.languageDetails, required this.valueScaler});
  final LanguageSubmission languageDetails;
  final Function valueScaler;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: valueScaler(context, 26),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: valueScaler(context, 48),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(
                      valueScaler(context, 16),
                    ),
                  ),
                  child: Center(
                    heightFactor: 1,
                    child: Padding(
                      padding: EdgeInsets.all(valueScaler(context, 4)),
                      child: Text(
                        languageDetails.problemsSolved.toString(),
                        style: TextStyle(
                          fontSize: valueScaler(context, 14),
                          color: Colors.teal[900],
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
