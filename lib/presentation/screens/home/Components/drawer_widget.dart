import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Data/cubit/authentication/log_out_cubit/log_out_cubit.dart';
import '../../../../Data/cubit/authentication/log_out_cubit/log_out_state.dart';
import '../../../../app/constants.dart';
import '../../../../app/styles/icons.dart';
import '../../../../app/utils/my_application.dart';
import '../../../../app/utils/shared_preference.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../../../widgets/shared.dart';
import '../../edit_profile/edit_profile_screen.dart';
import '../../notification/notification_screen.dart';
import '../../settings/settings_screen.dart';
import '../../terms_and_conditions/terms_conditions_screen.dart';
import '../../wallet/wallet_screen.dart';

Drawer buildHomeDrawerWidget(BuildContext context) {
  return Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
    ),
    child: ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: MyApplication.hightClc(context, 30),
              bottom: 12,
              right: 24,
              left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(sharedPrefs.getUserPhoto()),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 6,
                        color: const Color(0XFF7C7C84).withOpacity(0.2))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  sharedPrefs.getUserName(),
                  style: Constants.mainTitleFont,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(nasehBadge),
                  const SizedBox(width: 8),
                  Text("ناصح",
                      style: Constants.secondaryTitleRegularFont.copyWith(
                        color: Constants.primaryAppColor,
                      ))
                ],
              )
            ],
          ),
        ),
        myListTile(
            icon: ta3delProfile,
            name: "Edit Profile".tr,
            onTapHandler: () =>
                MyApplication.navigateTo(context, const EditProfileScreen())),
        myListTile(
            icon: mahfazty,
            name: "My Wallet".tr,
            onTapHandler: () {
              // Navigator.pop(context);
              MyApplication.navigateTo(context, const WalletScreen());
            }),
        myListTile(
            icon: notificationIcon,
            name: "Notifications".tr,
            onTapHandler: () {
              // Navigator.pop(context);
              MyApplication.navigateTo(context, const NotificationScreen());
            }),
        myListTile(
            icon: settingIcon,
            name: "Settings".tr,
            onTapHandler: () {
              // Navigator.pop(context);
              MyApplication.navigateTo(context, const SettingsScreen());
            }),
        myListTile(
            icon: shorot,
            name: "terms & Conditions".tr,
            onTapHandler: () {
              // Navigator.pop(context);
              MyApplication.navigateTo(context, const TermsConditionsScreen());
            }),
        myListTile(
            icon: techIcon,
            name: "Tech".tr,
            onTapHandler: () {
              launchUrl(
                Uri.parse('https://wa.me/+966502374223'),
              );
            }),
        myListTile(icon: knowAboutIcon, name: "Know".tr),
        BlocBuilder<LogOutCubit, LogOutState>(
            builder: (context, state) => state is LogOutLoading
                ? const CustomLoadingIndicator()
                : myListTile(
                    icon: logOut,
                    name: "Sign Out".tr,
                    onTapHandler: () {
                      context.read<LogOutCubit>().logOut(context: context);
                    })),
      ],
    ),
  );
}

ListTile myListTile(
    {required String icon, required String name, Function()? onTapHandler}) {
  return ListTile(
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      leading: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            icon,
            colorFilter: getFilterColor(Colors.black),
          ),
        ),
      ),
      title: Text(
        name,
        style: Constants.secondaryTitleRegularFont
            .copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: onTapHandler);
}
