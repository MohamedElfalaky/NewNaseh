import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/app/theme/app_theme.dart';
import 'package:nasooh/app/utils/my_application.dart';
import 'package:nasooh/presentation/screens/authentication/LoginScreen/login_screen.dart';
import 'package:nasooh/presentation/screens/authentication/RegistrationCycle/RegistrationStage3/registration_stage3.dart';
import 'package:nasooh/presentation/screens/settings/lang_item.dart';

import 'app/keys.dart';
import 'app/utils/bloc_providers.dart';
import 'app/utils/shared_preference.dart';

class NasehApp extends StatelessWidget {
  const NasehApp({super.key});

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
            home: RegistrationStage3(),
            // home: sharedPrefs.getToken != ""
            //     ? const HomeScreen()
            //     : const LoginScreen(),
          ),
        ),

    );
  }
}
