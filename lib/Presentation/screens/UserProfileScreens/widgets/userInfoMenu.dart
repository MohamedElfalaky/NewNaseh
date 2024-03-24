import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/constants.dart';

class SettingsMenuItem {
  final String title;
  final SvgPicture svg;
  final SvgPicture? trailingSvg = SvgPicture.asset(
    'assets/images/SVGs/arrow.svg',
    // width: 24,
  );
  bool? hasTrailingSvg = true;

  SettingsMenuItem({
    required this.title,
    required this.svg,
  });
}

class SettingsMenuItems {
  static SettingsMenuItem myOrders = SettingsMenuItem(
    title: "my_orders".tr,
    svg: SvgPicture.asset('assets/images/SVGs/wallet.svg', width: 24),
  );
  static SettingsMenuItem wallet = SettingsMenuItem(
    title: "my_wallet".tr,
    svg: SvgPicture.asset(
      'assets/images/SVGs/wallet.svg',
    ),
  );
  static SettingsMenuItem settings = SettingsMenuItem(
    title: "settings".tr,
    svg: SvgPicture.asset(
      'assets/images/SVGs/settings.svg',
    ),
  );

  static SettingsMenuItem terms = SettingsMenuItem(
    title: "terms_conditions".tr,
    svg: SvgPicture.asset(
      'assets/images/SVGs/book.svg',
    ),
  );

  static SettingsMenuItem support = SettingsMenuItem(
    title: "support".tr,
    svg: SvgPicture.asset(
      'assets/images/SVGs/help.svg',
    ),
  );
  static SettingsMenuItem nasouh = SettingsMenuItem(
    title: "know_nasouh".tr,
    svg: SvgPicture.asset(
      'assets/images/SVGs/ask.svg',
    ),
  );
  static final all = <SettingsMenuItem>[
    SettingsMenuItems.myOrders,
    SettingsMenuItems.wallet,
    SettingsMenuItems.settings,
    SettingsMenuItems.terms,
    SettingsMenuItems.support,
    SettingsMenuItems.nasouh,
  ];
}

Widget buildMenuItem(SettingsMenuItem menuItem) => ListTileTheme(
      selectedColor: Colors.white70,
      child: ListTile(
        // selectedTileColor: Colors.red,
        // selected: currentItem == menuItem,
        minLeadingWidth: 20,
        title: Text(
          menuItem.title,
          style: Constants.mainTitleFont,
        ),
        leading: menuItem.svg,
        trailing: menuItem.trailingSvg,
        onTap: () {
          // onSelectedItem(menuItem);
        },
      ),
    );
