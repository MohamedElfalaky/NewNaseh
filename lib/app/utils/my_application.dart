import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nasooh/app/utils/shared_preference.dart';

import '../constants.dart';

class MyApplication {
  static double hightClc(BuildContext context, int myHeight) {
    return MediaQuery.of(context).size.height * myHeight / 812;
  }

  static double widthClc(BuildContext context, int myWidth) {
    return MediaQuery.of(context).size.width * myWidth / 375;
  }

  static void navigateToReplace(BuildContext context, Widget page) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateTo(BuildContext context, Widget page) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateToReplaceAllPrevious(
      BuildContext context, Widget page) async {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  static showToastView({
    required String message,
  }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Constants.primaryAppColor,
        textColor: Constants.whiteAppColor,
        fontSize: 16.0);
  }

  handleUnAuthenticatedUser(String msg, BuildContext context) {
    if (msg == 'Unauthenticated.') {
      sharedPrefs.removeToken();
      sharedPrefs.removeAmount();
      sharedPrefs.setIsSignedIn(false);
      sharedPrefs.setIsCurrentAddress(true);
    }
  }
  static unFocusCursorRTL(TextEditingController controller) {
    if (controller.selection ==
        TextSelection.fromPosition(
            TextPosition(offset: controller.text.length - 1))) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }
  static void dismissKeyboard() {

    if (FocusManager.instance.primaryFocus?.hasFocus==true) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
