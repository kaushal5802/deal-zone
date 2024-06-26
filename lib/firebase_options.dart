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
    apiKey: 'AIzaSyDu_QA3dkmuvJ7Kq8QFYDOmsC1IdmORAQQ',
    appId: '1:6356253320:web:d9b73489ac8748a1f9bd3d',
    messagingSenderId: '6356253320',
    projectId: 'deal-49a37',
    authDomain: 'deal-49a37.firebaseapp.com',
    storageBucket: 'deal-49a37.appspot.com',
    measurementId: 'G-VME926SEQG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMPvmWqDhjCrTDDA9zFYYI7KON3wnND5c',
    appId: '1:6356253320:android:129376973cd96270f9bd3d',
    messagingSenderId: '6356253320',
    projectId: 'deal-49a37',
    storageBucket: 'deal-49a37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGqYyD8NPidpXtx9PNO4FNipsaTZPcFwA',
    appId: '1:6356253320:ios:a99cb0b537ba3361f9bd3d',
    messagingSenderId: '6356253320',
    projectId: 'deal-49a37',
    storageBucket: 'deal-49a37.appspot.com',
    iosBundleId: 'com.example.dealZone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGqYyD8NPidpXtx9PNO4FNipsaTZPcFwA',
    appId: '1:6356253320:ios:b9845c7bd373f747f9bd3d',
    messagingSenderId: '6356253320',
    projectId: 'deal-49a37',
    storageBucket: 'deal-49a37.appspot.com',
    iosBundleId: 'com.example.dealZone.RunnerTests',
  );
}
