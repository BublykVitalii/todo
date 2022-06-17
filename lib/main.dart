import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/auth/domain/auth_service.dart';
import 'package:flutter_theme/firebase_options.dart';
import 'package:flutter_theme/infrastructure/injectable.init.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final getIt = GetIt.instance;
  await configureDependencies(getIt);

  final AuthService authService = getIt.get<AuthService>();
  final loggedIn = await authService.inLoggedIn();

  if (loggedIn) {
    try {
      getIt.get<AuthService>().inLoggedIn();
    } catch (_) {
      authService.logOut();
    }
  }

  runApp(MyApp(inLoggedIn: loggedIn));
}
