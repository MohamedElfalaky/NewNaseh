import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nasooh/naseh_app.dart';

import 'Data/repositories/notification/fcm.dart';
import 'app/utils/shared_preference.dart';

// 562131705
// Aa@123123
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove;

  await SharedPrefs().init();
  await Firebase.initializeApp();
  FirebaseCustomNotification.setUpFirebase();

  runApp(const NasehApp());
}
