import 'package:flutter/material.dart';
import 'package:ui_elements/providers/theme.dart';

class ProfileImportProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileImportProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      backgroundColor: ThemeModeModel.lightPrimaryComplementary,
      color: ThemeModeModel.lightSecondaryInverse,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 0);
}
