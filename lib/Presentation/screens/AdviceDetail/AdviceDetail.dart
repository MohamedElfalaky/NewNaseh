import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class AdviceDetail extends StatefulWidget {
  const AdviceDetail({
    super.key,
  });

  @override
  State<AdviceDetail> createState() => _AdviceDetailState();
}

class _AdviceDetailState extends State<AdviceDetail> {
  HomeController homeController = HomeController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
    _textController.dispose();
    _focusNode.dispose();
    subscription.cancel();
    for (var element in homeController.categories) {
      element["isSelected"] = false;
    }
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
          key: _scaffoldKey,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              // toolbarHeight: 90,
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("محمد عبدالعزيز الحميد كامل"),
                      Text(
                        "12/2/2022 - 10:46 ص",
                        style: Constants.subtitleFont
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    logoColor,
                    color: Constants.primaryAppColor,
                    height: 50,
                  )
                ],
              ),
              leading: const myBackButton()),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  children: [
                    Advicess(
                      isAdviceDetal: true,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(8),
                        // constraints: BoxConstraints(mi),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 185, 184, 180)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "تفاصيل النصيحة هناك حقيقة مثبتة منذ زمن ط ويل وهي أن المقروء لصفحة ما  سيلهي القارئ عن التركيز على الشكل الخارجهناك حقيقة مثبتة منذ زمن ط ويل وهي أن المحتوىالمقروء لصفحة ما  سيلهي القارئ عن التركيز على الشكل الخارج  ",
                          style: Constants.subtitleFont,
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              focusNode: _focusNode,
                              decoration: Constants.setTextInputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(attachFiles),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(micee),
                                    SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                                hintText: "آكتب رسالتك...",
                              ).copyWith(
                                hintStyle: Constants.subtitleRegularFontHint
                                    .copyWith(color: Color(0XFF5C5E6B)),
                                enabledBorder: const OutlineInputBorder(
                                  gapPadding: 0,
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xffF5F4F5),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsetsDirectional.only(start: 8),
                              padding: EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0XFF273043)),
                              child: SvgPicture.asset(
                                sendChat,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
