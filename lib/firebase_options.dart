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
    apiKey: 'AIzaSyDzYffmOvbXfVOUY9BoyhSjhKuldl5jn-c',
    appId: '1:199455342580:web:31447e64ec90e45ad883a1',
    messagingSenderId: '199455342580',
    projectId: 'tak-estate-e8651',
    authDomain: 'tak-estate-e8651.firebaseapp.com',
    storageBucket: 'tak-estate-e8651.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDo9Ef1m7WWWLXs_eccOjmO-iS5KfwQpY',
    appId: '1:199455342580:android:abc2b5185af56d52d883a1',
    messagingSenderId: '199455342580',
    projectId: 'tak-estate-e8651',
    storageBucket: 'tak-estate-e8651.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvyCMjBRkIX-B1k9unIvB1nCjCcwrnHOg',
    appId: '1:199455342580:ios:f2db662e9ecd464fd883a1',
    messagingSenderId: '199455342580',
    projectId: 'tak-estate-e8651',
    storageBucket: 'tak-estate-e8651.appspot.com',
    iosBundleId: 'com.jubileesystem.tak.tak',
  );
}