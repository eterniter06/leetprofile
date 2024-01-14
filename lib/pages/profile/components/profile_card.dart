import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/providers/theme.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.children,
    this.header,
    this.contentPadding,
    this.trailer,
  });

  final List<Widget>? children;
  final String? header;
  final Widget? trailer;

  /// Default padding is EdgeInsets.zero
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              fit: StackFit.loose,
              children: [
                if (header != null)
                  Consumer<ThemeModeModel>(
                    builder: (context, themeModeModel, child) => Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
                      child: Text(
                        header!,
                        style: TextStyle(
                          fontSize: 18,
                          color: themeModeModel.equivalentThemeMode(
                                      platformBrightness) ==
                                  ThemeMode.light
                              ? ThemeModeModel.lightPrimaryInverse
                              : ThemeModeModel.lightPrimary,
                        ),
                      ),
                    ),
                  ),
                if (trailer != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: trailer!,
                  ),
              ],
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
