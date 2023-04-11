import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AdviceDetail/AdviceDetail.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/Components/outComeandRate.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          drawer: Drawer(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MyApplication.hightClc(context, 50),
                      bottom: 12,
                      right: 24,
                      left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 6,
                                color:
                                    const Color(0XFF7C7C84).withOpacity(0.2))),
                        child: SvgPicture.asset(
                          onboardingImage,
                          height: 70,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        "محمد عبدالعزيز الحميد كامل",
                        style: Constants.mainTitleFont,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(nasehBadge),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("ناصح",
                              style:
                                  Constants.secondaryTitleRegularFont.copyWith(
                                color: Constants.primaryAppColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                myListile(
                  iconn: ta3delProfile,
                  namee: "طلباتي",
                  // onTapHandler:
                  //     MyApplication.showToastView(message: "sjhsk")
                ),
                myListile(
                    iconn: mahfazty,
                    namee: "محفظتي",
                    onTapHandler: () =>
                        MyApplication.showToastView(message: "sjns")),
                myListile(iconn: mahfazty, namee: "الأشعارات"),
                myListile(iconn: shorot, namee: "الإعدادات"),
                myListile(iconn: shorot, namee: 'الشروط والأحكام'),
                myListile(iconn: shorot, namee: 'الدعم الفني'),
                myListile(iconn: shorot, namee: 'تعرف علي تطبيق نصوح'),
                myListile(iconn: logOut, namee: 'تسجيل الخروج'),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
                  child: Text(
                    "رقم الأصدار 1.0.0.1",
                    style: Constants.subtitleFont,
                  ),
                )
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // Appbar
                Container(
                  height: MyApplication.hightClc(context, 160),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Constants.primaryAppColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      appbarButton(
                          myIcon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onTapHandler: () {
                            _scaffoldKey.currentState!.openDrawer();
                            if (_scaffoldKey.currentState!.isDrawerOpen) {
                              // Check if the drawer is open
                              _focusNode.unfocus(); // Unfocus the text field
                            }
                          }),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "حياك الله بنصوح",
                            style: Constants.secondaryTitleRegularFont
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "Mohamed Ahmed Mohamed",
                            style: Constants.secondaryTitleFont
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        logoColor,
                        color: Colors.white,
                        height: 60,
                      )
                    ],
                  ),
                ),

                // starting from search field
                Positioned(
                  top: MyApplication.hightClc(context, 160) -
                      25, // to overlay the appbar
                  child: Container(
                    // this hight to make the container takes the remaining hight of the page
                    height: MediaQuery.of(context).size.height -
                        MyApplication.hightClc(context, 160) +
                        25,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          decoration:
                              Constants.setRegistrationTextInputDecoration(
                            prefixIcon: SvgPicture.asset(searchIcon),
                            hintText: "ابحث عن الطلبات...",
                          ).copyWith(
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                color:
                                    const Color(0xff0085A5).withOpacity(0.25),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // border: const OutlineInputBorder(
                            //   gapPadding: 0,
                            //   borderSide: BorderSide(
                            //     color: Color(0xff27AE60),
                            //   ),
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(24),
                            //   ),
                            // )
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutcomeAndRate(
                                  title: "الأرباح الكلية",
                                  subtitle: "12.725 SR",
                                  colorr: Constants.primaryAppColor,
                                ),
                                OutcomeAndRate(
                                  title: "التقييم الإجمالي",
                                  subtitle: "4.8",
                                  colorr: const Color(0xFF27AE60),
                                )
                              ],
                            )),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...homeController.categories.map((e) =>
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 8),
                                    decoration: BoxDecoration(
                                        color: e["isSelected"]
                                            ? Constants.primaryAppColor
                                            : const Color(0xff2730431A)
                                                .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        setState(() {
                                          for (var element
                                              in homeController.categories) {
                                            element["isSelected"] = false;
                                          }
                                          e["isSelected"] = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                              e["name"],
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constants.mainFont,
                                                  color: e["isSelected"]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "2",
                                              style: TextStyle(
                                                color: e["isSelected"]
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () => MyApplication.navigateTo(
                                  context, AdviceDetail()),
                              child: Advicess()),
                          itemCount: 4,
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  ListTile myListile(
      {required String iconn,
      required String namee,
      Function()? onTapHandler}) {
    return ListTile(
        minLeadingWidth: 10,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        leading: SvgPicture.asset(iconn, color: const Color(0XFF5C5E6B)),
        title: Text(
          namee,
          style: Constants.secondaryTitleRegularFont
              .copyWith(color: const Color(0XFF5C5E6B)),
        ),
        onTap: onTapHandler);
  }
}
