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
    apiKey: 'AIzaSyAb8Lc6wU6LcvvabPoWsun6OZ9YG-pMcnQ',
    appId: '1:270170057499:web:ac237b20aec90b653fc1be',
    messagingSenderId: '270170057499',
    projectId: 'chaty-713ff',
    authDomain: 'chaty-713ff.firebaseapp.com',
    storageBucket: 'chaty-713ff.appspot.com',
    measurementId: 'G-9GVB3QD3R5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTh5MKarNrNp3FrzMAZ2OlTLIUmzwks9s',
    appId: '1:270170057499:android:30e7b583b3ccb7133fc1be',
    messagingSenderId: '270170057499',
    projectId: 'chaty-713ff',
    storageBucket: 'chaty-713ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYavNeKeb2qzX0wuSicu-Ddf27x4hPGLw',
    appId: '1:270170057499:ios:b5927a8385f125b73fc1be',
    messagingSenderId: '270170057499',
    projectId: 'chaty-713ff',
    storageBucket: 'chaty-713ff.appspot.com',
    iosBundleId: 'com.example.chaty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYavNeKeb2qzX0wuSicu-Ddf27x4hPGLw',
    appId: '1:270170057499:ios:b5927a8385f125b73fc1be',
    messagingSenderId: '270170057499',
    projectId: 'chaty-713ff',
    storageBucket: 'chaty-713ff.appspot.com',
    iosBundleId: 'com.example.chaty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAb8Lc6wU6LcvvabPoWsun6OZ9YG-pMcnQ',
    appId: '1:270170057499:web:d08e98ea8b739ac13fc1be',
    messagingSenderId: '270170057499',
    projectId: 'chaty-713ff',
    authDomain: 'chaty-713ff.firebaseapp.com',
    storageBucket: 'chaty-713ff.appspot.com',
    measurementId: 'G-VTV2CW34QC',
  );
}
