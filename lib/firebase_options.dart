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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDn9D-8rOdG1DxTtpv1BLxbtKzwDPgayEA',
    appId: '1:349362216449:web:a6c3dc5cf1aaa33d4fea00',
    messagingSenderId: '349362216449',
    projectId: 'newapp-b3303',
    authDomain: 'newapp-b3303.firebaseapp.com',
    storageBucket: 'newapp-b3303.firebasestorage.app',
    measurementId: 'G-Z7P1SJ2EH6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9uJIQUIJfc8H3bx_bLAcgP4uHBZYFax4',
    appId: '1:349362216449:android:cbadd484738a3eaa4fea00',
    messagingSenderId: '349362216449',
    projectId: 'newapp-b3303',
    storageBucket: 'newapp-b3303.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7bE5ZKn9VluZIIEhpN4yIQa4Krv6vPHQ',
    appId: '1:349362216449:ios:770cbe72a926b7094fea00',
    messagingSenderId: '349362216449',
    projectId: 'newapp-b3303',
    storageBucket: 'newapp-b3303.firebasestorage.app',
    iosBundleId: 'com.example.littleVers',
  );
}