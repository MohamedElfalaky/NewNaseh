import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage3/RegistrationStage3.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';

import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.whiteAppColor,
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 70,
          title: Row(
            children: const [
              Text("تعديل الملف الشخصي"),
            ],
          ),
          leading: const myBackButton(),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "المعلومات الشخصية",
                        style: Constants.mainTitleFont,
                      ),
                      children: []),
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "معلومات التخصص",
                        style: Constants.mainTitleFont,
                      ),
                      children: []),
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "مجالات التخصص",
                        style: Constants.mainTitleFont,
                      ),
                      children: []),
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "معلومات إضافية",
                        style: Constants.mainTitleFont,
                      ),
                      children: []),
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "بيانات الموقع وحسابات التواصل",
                        style: Constants.mainTitleFont,
                      ),
                      children: []),
                  SizedBox(
                    height: 90,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
