import 'package:flutter/material.dart';

class SkillChipTheme {
  BorderSide? side;
  TextStyle? labelStyle;
  Color? backgroundColor;

  SkillChipTheme({this.side, this.labelStyle, this.backgroundColor});
}

class ThemeModeModel extends ChangeNotifier {
  ThemeModeModel({required ThemeMode themeMode}) : _themeMode = themeMode;

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  void changeThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  static Color getInverseBW(Color color) {
    double luminance =
        (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue);
    return (luminance < 140)
        ? const Color(0xffffffff)
        : const Color(0xff000000);
  }

  static const Color darkBackground = Color.fromARGB(255, 19, 19, 19);

  static ThemeData dark = ThemeData(
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade600;
            }
            return black;
          },
        ),
      ),
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Overpass',
    scaffoldBackgroundColor: black,
    dialogBackgroundColor: black,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return lightSecondaryInverse;
          }
          if (states.contains(MaterialState.selected)) {
            return lightSecondaryInverse;
          }
          return Colors.grey;
        },
      ),
    ),
    cardTheme: const CardTheme(
      color: darkBackground,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return lightPrimaryInverse;
          }
          return darkBackground;
        },
      ),
      trackColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return lightPrimary;
          } else if (states.contains(MaterialState.pressed)) {
            return lightPrimary;
          }
          return lightSecondary;
        },
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: black,
      centerTitle: false,
      backgroundColor: lightPrimary,
      actionsIconTheme: IconThemeData(
        color: black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimary,
      foregroundColor: black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: lightSecondary,
      selectionColor: lightPrimaryInverse,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      outlineBorder: BorderSide(
        style: BorderStyle.solid,
        color: lightSecondary,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightPrimary,
        ),
      ),
      floatingLabelStyle: TextStyle(
        color: lightPrimary,
      ),
      contentPadding: EdgeInsets.only(left: 8),
      focusColor: lightPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimary;
          }
          return lightSecondary;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimaryInverse;
          }
          return lightSecondaryInverse;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: const MaterialStatePropertyAll(
            BorderSide(color: Color.fromARGB(255, 209, 164, 96))),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimary;
          }
          return lightSecondary;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimaryInverse;
          }
          return lightSecondaryInverse;
        }),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: ThemeModeModel.lightSecondaryInverse,
      actionBackgroundColor: Color.fromARGB(255, 255, 226, 182),
      showCloseIcon: true,
      closeIconColor: ThemeModeModel.lightPrimary,
      backgroundColor: lightBackground2,
    ),
  );

  // Contrasing pair of colors
  static const Color lightPrimary = Color(0xFFFAC16B);
  static const Color lightPrimaryInverse = Color(0xFF4A3008);

  static const Color lightSecondary = Color(0xFFFEF1DD);
  static const Color lightSecondaryInverse = Color(0xFF6F480C);

  static const Color lightTextSelection = Color(0xffFDECD1);

  static const Color lightBackground2 = Color(0xffFEF8ED);
  static const Color lightBackground = Color(0xfffffdf8);

  static const Color fundamentalBackground = Color.fromARGB(255, 247, 251, 255);
  static const Color fundamentalBorder = Color.fromARGB(255, 219, 237, 253);

  static const Color intermediateBackground =
      Color.fromARGB(255, 238, 248, 255);
  static const Color intermediateBorder = Color.fromARGB(255, 201, 231, 255);

  static const Color advancedBorder = Color.fromRGBO(144, 202, 249, 1);
  static const Color advancedBackground = Color.fromARGB(255, 223, 241, 255);

  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static SkillChipTheme fundamentalSkillChipTheme = SkillChipTheme(
    side: const BorderSide(
      color: fundamentalBorder,
    ),
    labelStyle: TextStyle(
      color: getInverseBW(fundamentalBackground),
    ),
    backgroundColor: fundamentalBackground,
  );

  static SkillChipTheme intermediateSkillChipTheme = SkillChipTheme(
    side: const BorderSide(
      color: intermediateBorder,
    ),
    labelStyle: TextStyle(
      color: getInverseBW(intermediateBackground),
    ),
    backgroundColor: intermediateBackground,
  );

  static SkillChipTheme advancedSkillChipTheme = SkillChipTheme(
    side: const BorderSide(
      color: advancedBorder,
    ),
    labelStyle: TextStyle(
      color: getInverseBW(advancedBackground),
    ),
    backgroundColor: advancedBackground,
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Overpass',
    scaffoldBackgroundColor: white,
    dialogBackgroundColor: lightBackground2,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return lightSecondaryInverse;
          }
          if (states.contains(MaterialState.selected)) {
            return lightSecondaryInverse;
          }
          return Colors.grey;
        },
      ),
    ),
    cardTheme: const CardTheme(
      color: lightBackground,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return lightSecondaryInverse;
        }
        if (states.contains(MaterialState.pressed)) {
          return lightSecondaryInverse;
        }
        return white;
      }),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: black,
      centerTitle: false,
      backgroundColor: lightPrimary,
      actionsIconTheme: IconThemeData(
        color: black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimary,
      foregroundColor: black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: lightPrimaryInverse,
      selectionColor: lightTextSelection,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      outlineBorder: BorderSide(
        style: BorderStyle.solid,
        color: lightPrimaryInverse,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey,
      )),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightPrimaryInverse,
        ),
      ),
      floatingLabelStyle: TextStyle(
        color: lightPrimaryInverse,
      ),
      contentPadding: EdgeInsets.only(left: 8),
      focusColor: lightPrimaryInverse,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimary;
          }
          return lightSecondary;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimaryInverse;
          }
          return lightSecondaryInverse;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: const MaterialStatePropertyAll(
            BorderSide(color: Color.fromARGB(255, 209, 164, 96))),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimary;
          }
          return lightSecondary;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return lightPrimaryInverse;
          }
          return lightSecondaryInverse;
        }),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: ThemeModeModel.lightSecondaryInverse,
      actionBackgroundColor: ThemeModeModel.lightBackground2,
      showCloseIcon: true,
      closeIconColor: ThemeModeModel.lightPrimary,
    ),
  );

  static TextStyle defaultSubtitleTextStyle =
      TextStyle(color: Colors.grey.shade600, fontFamily: 'Overpass');

  static ThemeMode themeModeFromString(String? modeAsString) {
    if (modeAsString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    } else if (modeAsString == ThemeMode.light.toString()) {
      return ThemeMode.light;
    } else if (modeAsString == ThemeMode.system.toString()) {
      return ThemeMode.system;
    } else {
      throw "Invalid value for ThemeMode: $modeAsString";
    }
  }

  ThemeMode equivalentThemeMode(Brightness platformBrightness) {
    if (themeMode == ThemeMode.system) {
      return platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    return themeMode;
  }
}
