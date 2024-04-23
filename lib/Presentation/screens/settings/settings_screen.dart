import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/settings_cubits/is_notification_cubit/is_notification_cubit.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/shared_preference.dart';

import '../../../Data/cubit/authentication/delete_account_cubit/delete_account_cubit.dart';
import '../../../Data/cubit/authentication/delete_account_cubit/delete_account_state.dart';
import '../../../Data/cubit/settings_cubits/is_advice_cubit/is_advice_cubit.dart';
import '../../../app/styles/icons.dart';
import '../../widgets/custom_loading_widget.dart';
import 'lang_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? isNotificationValue;
  bool? isAdviceValue;

  @override
  void initState() {
    super.initState();

    isNotificationValue = sharedPrefs.getIsNotification() == 1 ? true : false;
    isAdviceValue = sharedPrefs.getIsAdvice() == 1 ? true : false;
    debugPrint("isNotificationValue is $isNotificationValue");
    debugPrint("isAdviceValue is $isAdviceValue");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            leadingWidth: 70,
            title: Text("Settings".tr),
            leading: const CustomBackButton()),
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
        ));
  }
}

Future<void> _showDeleteDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
          builder: (context, state) => AlertDialog(
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
                      ? const CustomLoadingIndicator()
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
