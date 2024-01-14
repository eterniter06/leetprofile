import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/providers/theme.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.children,
    this.profileHeader,
    this.contentPadding,
  });

  final List<Widget>? children;
  final String? profileHeader;

  /// Default padding is EdgeInsets.zero
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (profileHeader != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ThemeModeModel>(
                  builder: (context, themeModeModel, child) => Text(
                    profileHeader!,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeModeModel
                                  .equivalentThemeMode(platformBrightness) ==
                              ThemeMode.light
                          ? ThemeModeModel.lightPrimaryInverse
                          : ThemeModeModel.lightPrimary,
                    ),
                  ),
                ),
              ),
            if (children != null)
              ...(children!
                  .map(
                    (widget) => contentPadding == null
                        ? widget
                        : Padding(
                            padding: contentPadding!,
                            child: widget,
                          ),
                  )
                  .toList()),
          ],
        ),
      ),
    );
  }
}
