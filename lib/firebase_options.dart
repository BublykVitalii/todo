// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXK3wi1f-Ji-KkQTlYC9JzVrkiC0GhGwU',
    appId: '1:294198942024:web:605206a97d71dbfcd67b7d',
    messagingSenderId: '294198942024',
    projectId: 'todo-73d7b',
    authDomain: 'todo-73d7b.firebaseapp.com',
    storageBucket: 'todo-73d7b.appspot.com',
    measurementId: 'G-1EW27XCQL0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtrgJBoMJtv8wh3wolkWEDsLeh6y3Gdl4',
    appId: '1:294198942024:android:4d3d084020d59ed8d67b7d',
    messagingSenderId: '294198942024',
    projectId: 'todo-73d7b',
    storageBucket: 'todo-73d7b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGn3_v8BILEixi0KV2deXhaSrrbvCj4YU',
    appId: '1:294198942024:ios:12b0abdc28237696d67b7d',
    messagingSenderId: '294198942024',
    projectId: 'todo-73d7b',
    storageBucket: 'todo-73d7b.appspot.com',
    iosClientId: '294198942024-f52b0vi8v2n2dv0k7u9lu7ufig20mb40.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTheme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGn3_v8BILEixi0KV2deXhaSrrbvCj4YU',
    appId: '1:294198942024:ios:12b0abdc28237696d67b7d',
    messagingSenderId: '294198942024',
    projectId: 'todo-73d7b',
    storageBucket: 'todo-73d7b.appspot.com',
    iosClientId: '294198942024-f52b0vi8v2n2dv0k7u9lu7ufig20mb40.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTheme',
  );
}
