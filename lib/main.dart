import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/app/constants.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'Data/repositories/notification/fcm.dart';
import 'Presentation/screens/SettingsScreen/lang_item.dart';
import 'app/keys.dart';
import 'app/utils/BlocProviders.dart';
import 'app/utils/sharedPreferenceClass.dart';

// todo
// 562131705
// Aa@123123
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(initialization);
  await SharedPrefs().init();
  await Firebase.initializeApp();
  FirebaseCustomNotification.setUpFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GetMaterialApp(
        translations: Messages(),
        locale: sharedPrefs.getLanguage() == ""
            ? const Locale('ar')
            : Locale(sharedPrefs.getLanguage()),
        fallbackLocale: const Locale('ar'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar'), Locale('en')],
        navigatorKey: Keys.navigatorKey,
        builder: (context2, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: false,
            mediaQueryData:
                MediaQuery.of(context2).copyWith(textScaler: const TextScaler.linear(1.0)),
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000,
                  name: TABLET, scaleFactor: 1.3),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'ناصح',
        theme: ThemeData(
            primaryColor: Constants.primaryAppColor,
            primarySwatch: Colors.lightBlue,
            appBarTheme: const AppBarTheme().copyWith(
              toolbarHeight: 70,
              titleSpacing: 4,
              color: Constants.whiteAppColor,
              elevation: 0,
              titleTextStyle: Constants.mainTitleFont,
            ),
            scaffoldBackgroundColor: Constants.whiteAppColor),
        home: sharedPrefs.getToken() != ""
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}

Future<void> initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}
