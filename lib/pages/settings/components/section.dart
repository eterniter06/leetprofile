import 'package:flutter/material.dart';
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
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              header,
              style:
                  const TextStyle(color: ThemeModeModel.lightSecondaryInverse),
            ),
          ),
          if (children != null) ...children!,
        ]);
  }
}
