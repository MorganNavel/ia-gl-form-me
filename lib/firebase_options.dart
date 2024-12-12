// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCA3cmQDypCZACGNCh6a8CzYMrcWQpd-Fk',
    appId: '1:533823868562:web:477e55593ebe1c3b2d604b',
    messagingSenderId: '533823868562',
    projectId: 'formme-39cc9',
    authDomain: 'formme-39cc9.firebaseapp.com',
    storageBucket: 'formme-39cc9.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnbeGOMrijM8DkH2b4SbIgJI3AywiskBs',
    appId: '1:533823868562:android:062fffe7e3d1f59d2d604b',
    messagingSenderId: '533823868562',
    projectId: 'formme-39cc9',
    storageBucket: 'formme-39cc9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2gU2y95XEcElrl-nWMTdribtq0lD3Jdc',
    appId: '1:533823868562:ios:70cc7b233088fc242d604b',
    messagingSenderId: '533823868562',
    projectId: 'formme-39cc9',
    storageBucket: 'formme-39cc9.firebasestorage.app',
    iosBundleId: 'com.example.formMe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2gU2y95XEcElrl-nWMTdribtq0lD3Jdc',
    appId: '1:533823868562:ios:70cc7b233088fc242d604b',
    messagingSenderId: '533823868562',
    projectId: 'formme-39cc9',
    storageBucket: 'formme-39cc9.firebasestorage.app',
    iosBundleId: 'com.example.formMe',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCA3cmQDypCZACGNCh6a8CzYMrcWQpd-Fk',
    appId: '1:533823868562:web:7f31573e3de017e62d604b',
    messagingSenderId: '533823868562',
    projectId: 'formme-39cc9',
    authDomain: 'formme-39cc9.firebaseapp.com',
    storageBucket: 'formme-39cc9.firebasestorage.app',
  );
}
