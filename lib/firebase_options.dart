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
    apiKey: 'AIzaSyC6Ya0MTjnDw2UfGT40Sen5f9OADtEIaEg',
    appId: '1:440838776897:web:756a64bf978c57268d3ec0',
    messagingSenderId: '440838776897',
    projectId: 'handball-7a7b1',
    authDomain: 'handball-7a7b1.firebaseapp.com',
    storageBucket: 'handball-7a7b1.appspot.com',
    measurementId: 'G-WB77DRZ9E0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcRpdGlMXiXItO7vpZaYCmMHf9vVmEIsI',
    appId: '1:440838776897:android:17c045aa770d24b78d3ec0',
    messagingSenderId: '440838776897',
    projectId: 'handball-7a7b1',
    storageBucket: 'handball-7a7b1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDj85Iq9xi-gaITA0HvLeYx8uxmpNU9KY',
    appId: '1:440838776897:ios:fce1d511a5d943e48d3ec0',
    messagingSenderId: '440838776897',
    projectId: 'handball-7a7b1',
    storageBucket: 'handball-7a7b1.appspot.com',
    iosBundleId: 'com.example.handball',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDj85Iq9xi-gaITA0HvLeYx8uxmpNU9KY',
    appId: '1:440838776897:ios:218e855aaf8afafa8d3ec0',
    messagingSenderId: '440838776897',
    projectId: 'handball-7a7b1',
    storageBucket: 'handball-7a7b1.appspot.com',
    iosBundleId: 'com.example.handball.RunnerTests',
  );
}
