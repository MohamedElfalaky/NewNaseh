import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../app/utils/lang/language_constants.dart';

class RejectOrder extends StatefulWidget {
   RejectOrder(
      {required this.showAdData,
      super.key});

 ShowAdData? showAdData;

  @override
  State<RejectOrder> createState() => _RejectOrderState();
}

class _RejectOrderState extends State<RejectOrder> {
  final TextEditingController _textController = TextEditingController();

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
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
      if (result != ConnectivityResult.none) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                children: const [
                  Text("رفض الطلب"),
                ],
              ),
              leading: MyBackButton()),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  children: [
                    Advices(showAdData:widget.showAdData,
                      isAdviceDetail: false,
                    ),
                    TextField(
                      maxLines: 6,
                      decoration: Constants.setRegistrationTextInputDecoration(
                          isParagraph: true,
                          hintText: "سبب الرفض",
                          prefixIcon: Icon(
                            Icons.remove_circle_outline_outlined,
                            color: Color(0xffED2626),
                            size: 24,
                          )),
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: MyButton(
                          txt: "رفض الطلب",
                          onPressedHandler: () {},
                          isBold: true,
                        )),
                  ],
                ),
              ))),
    );
  }
}
