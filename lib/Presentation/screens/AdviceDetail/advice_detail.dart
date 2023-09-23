import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyButtonOutlined.dart';
import '../../widgets/noInternet.dart';
import '../../widgets/shared.dart';
import '../RegectOrder/RegectOrder.dart';

class AdviceDetail extends StatefulWidget {
  AdviceDetail({
    super.key,
    required this.showAdData,
  });

  ShowAdData? showAdData;

  @override
  State<AdviceDetail> createState() => _AdviceDetailState();
}

class _AdviceDetailState extends State<AdviceDetail> {
  HomeController homeController = HomeController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // AdviceDetailScreenModel adviceDetailScreenModel = AdviceDetailScreenModel();

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
            message: "noInternet".tr );
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
    // todo if not connected display nointernet widget.showAdData? else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(
          message: "noInternet".tr );
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
                      Text(widget.showAdData?.client?.fullName ?? ""),
                      Text(
                        widget.showAdData?.date ?? "",
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
              leading: MyBackButton(
                hasValue: true,
                onPressed: () {
                  MyApplication.navigateTo(context, const HomeScreen());
                },
              )),
          body: widget.showAdData?.status?.id == 2
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  width: 1, color: Constants.primaryAppColor)),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 6, bottom: 6, left: 16, right: 16),
                              child: Text(
                                widget.showAdData?.name ?? "",
                                style: Constants.mainTitleFont,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                Container(
                                  height: 22,
                                  width: 57,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF99E6FC),
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                              topStart: Radius.circular(10),
                                              bottomStart:
                                                  Radius.circular(10))),
                                  child: Text(
                                    widget.showAdData?.status?.name ?? "",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.mainFont),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: Row(
                                children: [
                                  SvgPicture.asset(nasehaCost),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 6),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: widget.showAdData?.price
                                                      .toString() ??
                                                  "",
                                              style: Constants
                                                  .headerNavigationFont
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color: Constants
                                                          .primaryAppColor)),
                                          TextSpan(
                                              text: 'ريال سعودي',
                                              style: Constants.subtitleFontBold
                                                  .copyWith(
                                                      color: Constants
                                                          .primaryAppColor)),
                                        ],
                                      ),
                                    ),
                                  )
                                  // Text("75 ريال سعودي",style: ,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 16, right: 16),
                              child: DottedLine(
                                dashColor:
                                    const Color(0xff0085A5).withOpacity(0.2),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  end: 8.0),
                                          child: MyButton(
                                            isBold: true,
                                            txt: "قبول",
                                            onPressedHandler: () {
                                              // MyApplication.navigateTo(
                                              //     context, RegistrationStage7());
                                            },
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: MyButtonOutlined(
                                          isBold: false,
                                          txt: "رفض",
                                          onPressedHandler: () {
                                            MyApplication.navigateTo(
                                                context,
                                                RejectOrder(showAdData:widget.showAdData,
                                                ));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ]),
                        )
                      ],
                    ),
                  ))
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Column(
                      children: [
                        Advices(
                          showAdData:widget.showAdData,
                          isAdviceDetail: true,
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
