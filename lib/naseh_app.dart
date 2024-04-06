import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/app/theme/app_theme.dart';
import 'package:nasooh/presentation/screens/authentication/LoginScreen/login_screen.dart';
import 'package:nasooh/presentation/screens/settings/lang_item.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'app/keys.dart';
import 'app/utils/bloc_providers.dart';
import 'app/utils/shared_preference.dart';

class NasehApp extends StatelessWidget {
  const NasehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GetMaterialApp(
        translations: Messages(),
        locale: Locale(sharedPrefs.getLanguage),
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
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET, scaleFactor: 1.3),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color:   Colors.white,
            ),
        ),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'ناصح',
        theme: whiteTheme,
        home: sharedPrefs.getToken() != ""
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}
