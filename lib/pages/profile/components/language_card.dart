import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.languageDetails,
  });
  final LanguageSubmission languageDetails;

  final Map<String, String> map = const {
    'bash': 'bash.svg',
    'c': 'c.svg',
    'c++': 'cplusplus.svg',
    'c#': 'csharp.svg',
    'java': 'java.svg',
    'javascript': 'javascript.svg',
    'ms sql server': 'mssql.svg',
    'mysql': 'mysql.svg',
    'python': 'pythonYellow.svg',
    'python3': 'python.svg',
    'typescript': 'typescript.svg',
    // Languages below haven't been tested and may not be rendered
    //due to a possible difference in how the language name is stored
    'dart': 'dart.svg',
    'elixir': 'elixir.svg',
    'erlang': 'erlang.svg',
    'go': 'go.svg',
    'kotlin': 'kotlin.svg',
    'oracle': 'oracle.svg',
    'php': 'php.svg',
    'racket': 'racket.svg',
    'ruby': 'ruby.svg',
    'scala': 'scala.svg',
    'swift': 'swift.svg',
  };

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: languageDetails.languageName!,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child:
                  map.containsKey(languageDetails.languageName!.toLowerCase())
                      ? SvgPicture.asset(
                          'assets/languages/${map[languageDetails.languageName!.toLowerCase()]!}',
                          height: 50,
                        )
                      : SizedBox(
                          height: 50,
                          child: Text(languageDetails.languageName!),
                        ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 52,
                  // padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: ThemeModeModel.fundamentalBackground,
                      border: Border.all(
                        color: ThemeModeModel.fundamentalBorder,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(80))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      languageDetails.problemsSolved.toString(),
                      style: TextStyle(
                        color: ThemeModeModel.getInverseBW(
                            ThemeModeModel.fundamentalBackground),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
