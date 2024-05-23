import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Data/repositories/notification/fcm.dart';
import 'Presentation/screens/Home/home_screen.dart';
import 'Presentation/screens/authentication/LoginScreen/login_screen.dart';
import 'Presentation/screens/settings/lang_item.dart';
import 'app/keys.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/bloc_providers.dart';
import 'app/utils/my_application.dart';
import 'app/utils/shared_preference.dart';

class NasehApp extends StatefulWidget {
  const NasehApp({super.key});

  @override
  State<NasehApp> createState() => _NasehAppState();
}

class _NasehAppState extends State<NasehApp> {
  @override
  void initState() {
    super.initState();
    FirebaseCustomNotification.setUpFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: providers,
        child: GestureDetector(
          onTap: ()=>MyApplication.dismissKeyboard(),
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
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,

            title: 'ناصح',
            theme: whiteTheme,
            home: sharedPrefs.getToken != ""
                ? const HomeScreen()
                : const LoginScreen(),
          ),
        ),

    );
  }
}
