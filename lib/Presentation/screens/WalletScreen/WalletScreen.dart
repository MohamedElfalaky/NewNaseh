import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nasooh/Presentation/screens/WalletScreen/Components/OneOrder.dart';
import 'package:nasooh/Presentation/screens/WalletScreen/controller/WalletScreenController.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen();

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletScreenController walletScreenController = WalletScreenController();

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

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
            message:  "noInternet".tr );
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
          message:  "noInternet".tr) ;
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                children: const [
                  Text("محفظتي"),
                ],
              ),
              leading:  MyBackButton()),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      child: Lottie.asset(
                        myWallet,
                        // fit: BoxFit.none,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "رصيد محفظتي",
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        // Text(
                        //   "1.435.83",
                        //   style: Constants.headerNavigationFont
                        //       .copyWith(fontSize: 32),
                        // ),
                        RichText(
                            text: TextSpan(
                                text: "1.435.83",
                                style: Constants.headerNavigationFont
                                    .copyWith(fontSize: 32),
                                children: [
                              TextSpan(
                                  text: "ريال سعودي",
                                  style: Constants.subtitleFont
                                      .copyWith(fontWeight: FontWeight.normal))
                            ]))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => OneOreder(),
                itemCount: 10,
              ))
            ],
          )),
    );
  }
}
