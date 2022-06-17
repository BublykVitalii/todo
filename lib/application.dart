import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_theme/screens/todo_screens/todo_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_theme/auth/screen/auth_screen.dart';
import 'package:flutter_theme/infrastructure/theme/dark_theme.dart';
import 'package:flutter_theme/infrastructure/theme/light_theme.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.inLoggedIn,
  }) : super(key: key);
  final bool inLoggedIn;
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = MaterialApp(
      title: 'Flutter theme',
      themeMode: _themeMode,
      theme: getLightTheme(context),
      darkTheme: getDarkTheme(context),
      onGenerateRoute: onGenerateRoute,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => context.localizations!.flutterTheme,
    );

    return MultiProvider(
      providers: [
        Provider.value(value: this),
        Provider.value(value: _themeMode),
      ],
      child: child,
    );
  }

  Route onGenerateRoute(RouteSettings? settings) {
    return widget.inLoggedIn ? TodoScreen.route : AuthScreen.route;
  }
}
