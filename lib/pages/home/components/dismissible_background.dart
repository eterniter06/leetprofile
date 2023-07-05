import 'package:flutter/material.dart';

class DismissableBackground extends StatelessWidget {
  const DismissableBackground({
    super.key,
    this.alignment,
  });

  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO: Extract theme properties to a single location. Below cannot be removed because of visibility issues in dark mode.
      // White background on white icon observed in dark mode without setting conditional background color
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      alignment: alignment,
      child: const Icon(Icons.delete),
    );
  }
}
