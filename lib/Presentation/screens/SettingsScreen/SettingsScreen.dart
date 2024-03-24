import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/settings_cubits/is_notification_cubit/is_notification_cubit.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';

import '../../../Data/cubit/authentication/delete_account_cubit/delete_account_cubit.dart';
import '../../../Data/cubit/authentication/delete_account_cubit/delete_account_state.dart';
import '../../../Data/cubit/settings_cubits/is_advice_cubit/is_advice_cubit.dart';
import '../../../app/utils/Language/get_language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  bool? isNotificationValue;
  bool? isAdviceValue;

  @override
  void initState() {
    super.initState();

    isNotificationValue = sharedPrefs.getIsNotification() == 1 ? true : false;
    isAdviceValue = sharedPrefs.getIsAdvice() == 1 ? true : false;
    print("isNotificationValue is $isNotificationValue");
    print("isAdviceValue is $isAdviceValue");

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
        MyApplication.showToastView(message: "noInternet".tr);
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
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: "noInternet".tr);
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
                txt: "Save".tr,
                onPressedHandler: () {},
              ),
            ),
          ),
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                children: [
                  Text("Settings".tr),
                ],
              ),
              leading: MyBackButton()),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(language),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "change lang".tr,
                      style: Constants.secondaryTitleFont,
                    )
                  ],
                ),
                const ChangeLangItem(),
                const Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(notifii),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Notifications".tr,
                        style: Constants.secondaryTitleFont,
                      ),
                      const Spacer(),
                      Switch(
                        value: isNotificationValue!,
                        onChanged: (value) {
                          setState(() {
                            isNotificationValue = value;
                          });
                          context.read<IsNotificationCubit>().isNotify();
                        },
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Receive Orders".tr,
                        style: Constants.secondaryTitleFont,
                      ),
                      const Spacer(),
                      Switch(
                        value: isAdviceValue!,
                        onChanged: (value) {
                          setState(() {
                            isAdviceValue = value;
                          });
                          context.read<IsAdviceCubit>().isAdvice();
                        },
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xff555B6E),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(deletAcc),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () => _showDeleteDialog(context),
                        child: Text(
                          "Delete Account".tr,
                          style: Constants.secondaryTitleFont
                              .copyWith(color: const Color(0XFFED2626)),
                        ),
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

Future<void> _showDeleteDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
          builder: (context, state) => AlertDialog(
                // <-- SEE HERE
                // title: const Text('Cancel booking'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("delete tile".tr),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("No".tr),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  state is DeleteAccountLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          child: Text("Yes".tr),
                          onPressed: () {
                            context.read<DeleteAccountCubit>().delete(
                                  context: context,
                                );
                            // Navigator.pop(context);
                          },
                        ),
                ],
              ));
    },
  );
}
