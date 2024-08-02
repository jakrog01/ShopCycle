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
    apiKey: 'AIzaSyC8l2WaFlz1XsH_ZudYlbTbBxM4yuNg64U',
    appId: '1:192503978580:web:a6ef6e6595dd26490b6bc1',
    messagingSenderId: '192503978580',
    projectId: 'shopcycle-3d0c3',
    authDomain: 'shopcycle-3d0c3.firebaseapp.com',
    storageBucket: 'shopcycle-3d0c3.appspot.com',
    measurementId: 'G-LE3WCE1C55',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlemUpbdZ5joFu3oNkQhCYRkPWiEZ5ZJA',
    appId: '1:192503978580:android:af1cfa83ed8bc7410b6bc1',
    messagingSenderId: '192503978580',
    projectId: 'shopcycle-3d0c3',
    storageBucket: 'shopcycle-3d0c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaMn-oOhXoSWy_yq7LmWX_QtnUeES76WE',
    appId: '1:192503978580:ios:fc23b2f6f20b82820b6bc1',
    messagingSenderId: '192503978580',
    projectId: 'shopcycle-3d0c3',
    storageBucket: 'shopcycle-3d0c3.appspot.com',
    iosBundleId: 'com.example.shopcycle',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaMn-oOhXoSWy_yq7LmWX_QtnUeES76WE',
    appId: '1:192503978580:ios:fc23b2f6f20b82820b6bc1',
    messagingSenderId: '192503978580',
    projectId: 'shopcycle-3d0c3',
    storageBucket: 'shopcycle-3d0c3.appspot.com',
    iosBundleId: 'com.example.shopcycle',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8l2WaFlz1XsH_ZudYlbTbBxM4yuNg64U',
    appId: '1:192503978580:web:4950777997d0e7470b6bc1',
    messagingSenderId: '192503978580',
    projectId: 'shopcycle-3d0c3',
    authDomain: 'shopcycle-3d0c3.firebaseapp.com',
    storageBucket: 'shopcycle-3d0c3.appspot.com',
    measurementId: 'G-KWKDFXXZTR',
  );
}
