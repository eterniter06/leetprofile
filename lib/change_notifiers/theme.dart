import 'package:flutter/material.dart';

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

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Overpass',
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

  // static ThemeData light = ThemeData.from(
  //   useMaterial3: true,
  //   colorScheme: const ColorScheme.light(
  //     brightness: Brightness.light,
  //     primary: lightPrimary,
  //     onPrimary: lightPrimaryInverse,
  //     secondary: lightSecondary,
  //     onSecondary: lightSecondaryInverse,
  //     background: Colors.white,
  //     onBackground: Colors.black,

  //   ),
  // );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Overpass',

    // ListTile is not themed here
    // For listTile, check lib/pages/home/components/user_list_tile.dart

    // textTheme: TextTheme(bodyMedium: TextStyle(color: Color(0xffF9BD5F))),
    // primaryTextTheme: TextTheme(),
    scaffoldBackgroundColor: white,
    dialogBackgroundColor: white,
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
  );

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
}
