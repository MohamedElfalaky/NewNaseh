import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _groupValue;

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(
            message: '${getTranslated(context, 'noInternet')}');
      }
    });

    // todo subscribe to internet change
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(
          message: '${getTranslated(context, 'noInternet')}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: MyButton(
                isBold: true,
                txt: "حفظ",
                onPressedHandler: () {},
              ),
            ),
          ),
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                children: const [
                  Text("الإعدادات"),
                ],
              ),
              leading: const MyBackButton()),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(language),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "تغيير اللغة",
                      style: Constants.secondaryTitleFont,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          activeColor: Constants.primaryAppColor,
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text(
                            "العربية",
                            style: Constants.secondaryTitleRegularFont,
                          ),
                          value: "العربية",
                          groupValue: _groupValue,
                          onChanged: (s) {
                            setState(() {
                              _groupValue = s;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          activeColor: Constants.primaryAppColor,
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text(
                            "English",
                            style: Constants.secondaryTitleRegularFont,
                          ),
                          value: "English",
                          groupValue: _groupValue,
                          onChanged: (s) {
                            setState(() {
                              _groupValue = s;
                            });
                          }),
                    )
                  ],
                ),
                Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(notifii),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "الأشعارات",
                        style: Constants.secondaryTitleFont,
                      ),
                      Spacer(),
                      Switch(
                        value: false,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "استقبال طلبات",
                        style: Constants.secondaryTitleFont,
                      ),
                      Spacer(),
                      Switch(
                        value: false,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(deletAcc),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "حذف الحساب",
                        style: Constants.secondaryTitleFont
                            .copyWith(color: Color(0XFFED2626)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
