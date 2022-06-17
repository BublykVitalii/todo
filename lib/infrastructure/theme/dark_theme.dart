import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme/infrastructure/theme/app_colors.dart';

const _colorTheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.green,
  onPrimary: AppColors.black,
  secondary: AppColors.green,
  onSecondary: AppColors.black,
  error: Colors.red,
  onError: Colors.red,
  background: AppColors.black,
  onBackground: Colors.white,
  surface: AppColors.black,
  onSurface: Colors.white,
);

Color _getCheckboxCheckedColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.black;
  }
  return AppColors.black;
}

Color _getCheckboxFillColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.green;
  }
  return Colors.grey;
}

Color _getSwitchTrackColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return AppColors.green;
  } else if (states.contains(MaterialState.selected)) {
    return AppColors.green;
  }

  return Colors.white;
}

Color _getSwitchThumbColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return AppColors.greenDark;
  } else if (states.contains(MaterialState.selected)) {
    return AppColors.greenDark;
  }

  return AppColors.green;
}

Color _getRadioFillColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.green;
  }
  return AppColors.greenDark;
}

BorderSide _getOutlinedColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return const BorderSide(color: Colors.white);
  }
  return const BorderSide(color: Colors.grey);
}

ThemeData getDarkTheme(BuildContext context) {
  final textTheme =
      Typography.material2018(platform: defaultTargetPlatform).white;

  final buttonScaledPadding = ButtonStyleButton.scaledPadding(
    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
  );

  final textButtonScaledPadding = ButtonStyleButton.scaledPadding(
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
  );

  return ThemeData.from(
    colorScheme: _colorTheme,
    textTheme: textTheme.apply(
      fontFamily: 'Open Sans',
      bodyColor: Colors.white,
      displayColor: Colors.white,
      decorationColor: AppColors.black,
    ),
  ).copyWith(
    iconTheme: const IconThemeData(color: AppColors.green),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green,
        primary: Colors.black,
        padding: textButtonScaledPadding,
      ).copyWith(
        side: MaterialStateProperty.resolveWith(_getOutlinedColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.black,
        onPrimary: AppColors.green,
        padding: buttonScaledPadding,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: AppColors.green,
        padding: buttonScaledPadding,
      ).copyWith(
        side: MaterialStateProperty.resolveWith(_getOutlinedColor),
      ),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((_getCheckboxFillColor)),
      checkColor: MaterialStateProperty.resolveWith(_getCheckboxCheckedColor),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith(_getSwitchTrackColor),
      thumbColor: MaterialStateProperty.resolveWith(_getSwitchThumbColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(_getRadioFillColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.green),
        borderRadius: BorderRadius.circular(20.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
