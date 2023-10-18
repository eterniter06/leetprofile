import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/providers/theme.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.header,
    this.children,
  });

  final String header;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Consumer<ThemeModeModel>(
              builder: (context, themeModeModel, child) => Text(
                header,
                style: TextStyle(
                    color: themeModeModel
                                .equivalentThemeMode(platformBrightness) ==
                            ThemeMode.light
                        ? ThemeModeModel.lightSecondaryInverse
                        : ThemeModeModel.lightPrimary),
              ),
            ),
          ),
          if (children != null) ...children!,
        ]);
  }
}
