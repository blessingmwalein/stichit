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
    apiKey: 'AIzaSyBAYtEyMOQgOff9VDxylDR8EVvtNISBkNo',
    appId: '1:902638070510:web:b80665d0411ba2a9ce61ff',
    messagingSenderId: '902638070510',
    projectId: 'stichit-80063',
    authDomain: 'stichit-80063.firebaseapp.com',
    storageBucket: 'stichit-80063.appspot.com',
    measurementId: 'G-VLWQJE2D8D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUMxxHgG30UQ9n_B5QqQMfXbuRLcER6eM',
    appId: '1:902638070510:android:b913f0afb780f260ce61ff',
    messagingSenderId: '902638070510',
    projectId: 'stichit-80063',
    storageBucket: 'stichit-80063.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4vBOHCpzcLXfbKmvg9BIwql1Jxr2icVQ',
    appId: '1:902638070510:ios:d0211e0ef09f86edce61ff',
    messagingSenderId: '902638070510',
    projectId: 'stichit-80063',
    storageBucket: 'stichit-80063.appspot.com',
    iosBundleId: 'com.example.stichit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4vBOHCpzcLXfbKmvg9BIwql1Jxr2icVQ',
    appId: '1:902638070510:ios:d0211e0ef09f86edce61ff',
    messagingSenderId: '902638070510',
    projectId: 'stichit-80063',
    storageBucket: 'stichit-80063.appspot.com',
    iosBundleId: 'com.example.stichit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBAYtEyMOQgOff9VDxylDR8EVvtNISBkNo',
    appId: '1:902638070510:web:4c7ff9bc31f9e74ece61ff',
    messagingSenderId: '902638070510',
    projectId: 'stichit-80063',
    authDomain: 'stichit-80063.firebaseapp.com',
    storageBucket: 'stichit-80063.appspot.com',
    measurementId: 'G-JKSN6634LG',
  );
}