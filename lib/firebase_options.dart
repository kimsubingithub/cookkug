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
    apiKey: 'AIzaSyA02Z1jdbzJGGd-Twf0e5pZALgFfxhMF_Q',
    appId: '1:97651949947:web:80d12ff6f0d35957923dde',
    messagingSenderId: '97651949947',
    projectId: 'cookkug-ce6c5',
    authDomain: 'cookkug-ce6c5.firebaseapp.com',
    storageBucket: 'cookkug-ce6c5.appspot.com',
    measurementId: 'G-8B4X0Z140Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAYxzwNFnv20PN3oIhEODmU5C1po0joyI',
    appId: '1:97651949947:android:8cedd88ea369a398923dde',
    messagingSenderId: '97651949947',
    projectId: 'cookkug-ce6c5',
    storageBucket: 'cookkug-ce6c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7C_8HOt6PENGYqMG57ZZyVuhEUiTMU88',
    appId: '1:97651949947:ios:25d112b550df8cc3923dde',
    messagingSenderId: '97651949947',
    projectId: 'cookkug-ce6c5',
    storageBucket: 'cookkug-ce6c5.appspot.com',
    iosClientId: '97651949947-df642opk6m5mpm6qvsaodu19lg9d7380.apps.googleusercontent.com',
    iosBundleId: 'com.swhackathon.cookkug',
  );
}
