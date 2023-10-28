import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/AdviceDetail/advice_detail.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/Components/outComeandRate.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/screens/NotificationScreen/NotificationScreen.dart';
import 'package:nasooh/Presentation/screens/SettingsScreen/SettingsScreen.dart';
import 'package:nasooh/Presentation/screens/TermsConditionsScreen/TermsConditionsScreen.dart';
import 'package:nasooh/Presentation/screens/WalletScreen/WalletScreen.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';

import '../../../Data/cubit/authentication/get_user_cubit/get_user_cubit.dart';
import '../../../Data/cubit/authentication/get_user_cubit/get_user_state.dart';
import '../../../Data/cubit/authentication/log_out_cubit/log_out_cubit.dart';
import '../../../Data/cubit/authentication/log_out_cubit/log_out_state.dart';
import '../../../Data/cubit/home/home_one_cubit/home_one_cubit.dart';
import '../../../Data/cubit/home/home_one_cubit/home_one_state.dart';
import '../../../Data/cubit/home/home_status_cubit/home_status_cubit.dart';
import '../../../Data/cubit/home/home_status_cubit/home_status_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../Data/models/home_models/home_status_model.dart';
import '../AdviceDetail/advice_new_detail.dart';
import '../EditProfileScreen/EditProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  Future<void> getDataFromApi() async {
    await context.read<HomeStatusCubit>().getDataHomeStatus();
    var cubitVal = HomeStatusCubit.get(context);
    context.read<ListOneHomeCubit>().getOneHome("");
    context.read<GetUserCubit>().getUserMethod();
  }

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        getDataFromApi();
      } else {
        MyApplication.showToastView(message: "noInternet".tr);
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
        getDataFromApi();
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

  int selectedIndex = 0;

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
      MyApplication.showToastView(message: "noInternet".tr);
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                            // shape: BoxShape.circle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 6,
                                color:
                                    const Color(0XFF7C7C84).withOpacity(0.2))),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(5),
                        //   child: Image.asset(
                        //     personn,
                        //     fit: BoxFit.cover,
                        //   ),
                        // )
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
                    iconn: ordersIcon,
                    namee: "My Orders".tr,
                    onTapHandler: () => Navigator.pop(context)),
                myListile(
                    iconn: ta3delProfile,
                    namee: "Edit Profile".tr,
                    onTapHandler: () => MyApplication.navigateTo(
                        context, const EditProfileScreen())),
                myListile(
                    iconn: mahfazty,
                    namee: "My Wallet".tr,
                    onTapHandler: () {
                      Navigator.pop(context);
                      MyApplication.navigateTo(context, const WalletScreen());
                    }),
                myListile(
                    iconn: notificationIcon,
                    namee: "Notifications".tr,
                    onTapHandler: () {
                      Navigator.pop(context);
                      MyApplication.navigateTo(
                          context, const NotificationScreen());
                    }),
                myListile(
                    iconn: settingIcon,
                    namee: "Settings".tr,
                    onTapHandler: () {
                      Navigator.pop(context);
                      MyApplication.navigateTo(context, const SettingsScreen());
                    }),
                myListile(
                    iconn: shorot,
                    namee: "terms & Conditions".tr,
                    onTapHandler: () {
                      Navigator.pop(context);
                      MyApplication.navigateTo(
                          context, const TermsConditionsScreen());
                    }),
                myListile(iconn: techIcon, namee: "Tech".tr),
                myListile(iconn: knowAboutIcon, namee: "Know".tr),
                BlocBuilder<LogOutCubit, LogOutState>(
                    builder: (context, state) => state is LogOutLoading
                        ? const Center(child: CircularProgressIndicator())
                        : myListile(
                            iconn: logOut,
                            namee: "Sign Out".tr,
                            onTapHandler: () {
                              context.read<LogOutCubit>().logOut(
                                    context: context,
                                  );
                              // Navigator.pop(context);

                              // MyApplication.navigateTo(
                              //     context, const LoginScreen());
                            })),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 25),
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
            child: BlocBuilder<HomeStatusCubit, HomeStatusState>(
                builder: (context, homeState) {
              if (homeState is HomeStatusLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (homeState is HomeStatusLoaded) {
                final List<Datum> dataList = homeState.response?.data ?? [];
                print(dataList);
                return Stack(
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
                          AppbarButton(
                              myIcon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              onTapHandler: () {
                                _scaffoldKey.currentState!.openDrawer();
                                if (_scaffoldKey.currentState!.isDrawerOpen) {
                                  // Check if the drawer is open
                                  _focusNode
                                      .unfocus(); // Unfocus the text field
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
                                sharedPrefs.getUserName(),
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
                                hintText: "Search for Orders".tr,
                              ).copyWith(
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderSide: BorderSide(
                                    color: const Color(0xff0085A5)
                                        .withOpacity(0.25),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 32),
                              child: BlocBuilder<GetUserCubit, GetUserState>(
                                  builder: (context, stateUser) {
                                if (stateUser is GetUserLoaded) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutcomeAndRate(
                                        assetName: moneyBag,
                                        title: "الأرباح الكلية",
                                        subtitle:
                                            "${stateUser.response?.data?.walletBalance ?? 0} SR",
                                        color: Constants.primaryAppColor,
                                      ),
                                      OutcomeAndRate(
                                        assetName: starIcon,
                                        title: "التقييم الإجمالي",
                                        subtitle:
                                            stateUser.response?.data?.rate ??
                                                "0",
                                        color: const Color(0xFF27AE60),
                                      )
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }),
                            ),
                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, int index) {
                                  return AnimatedContainer(
                                    height: 30,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 8),
                                    decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Constants.primaryAppColor
                                            : const Color(0xff2730431A)
                                                .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          if (selectedIndex == 0) {
                                            context
                                                .read<ListOneHomeCubit>()
                                                .getOneHome("");
                                          } else {
                                            context
                                                .read<ListOneHomeCubit>()
                                                .getOneHome(dataList[index]
                                                    .id
                                                    .toString());
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                              dataList[index].name ?? "",
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constants.mainFont,
                                                  color: selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              (dataList[index].total ?? 0)
                                                  .toString(),
                                              style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: dataList.length,
                              ),
                            ),

                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   child: Row(
                            //     children: [
                            //       ...homeController.categories.map((e) =>
                            //           AnimatedContainer(
                            //             duration: const Duration(milliseconds: 500),
                            //             curve: Curves.easeInOut,
                            //             margin: const EdgeInsetsDirectional.only(
                            //                 end: 8),
                            //             decoration: BoxDecoration(
                            //                 color: e["isSelected"]
                            //                     ? Constants.primaryAppColor
                            //                     : const Color(0xff2730431A)
                            //                     .withOpacity(0.1),
                            //                 borderRadius:
                            //                 BorderRadius.circular(15)),
                            //             child: InkWell(
                            //               borderRadius: BorderRadius.circular(15),
                            //               onTap: () {
                            //                 setState(() {
                            //                   for (var element
                            //                   in homeController.categories) {
                            //                     element["isSelected"] = false;
                            //                   }
                            //                   e["isSelected"] = true;
                            //                 });
                            //               },
                            //               child: Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: 12, vertical: 4),
                            //                 child: Row(
                            //                   children: [
                            //                     Text(
                            //                       e["name"],
                            //                       style: TextStyle(
                            //                           fontFamily:
                            //                           Constants.mainFont,
                            //                           color: e["isSelected"]
                            //                               ? Colors.white
                            //                               : Colors.black,
                            //                           fontSize: 12),
                            //                     ),
                            //                     const SizedBox(
                            //                       width: 12,
                            //                     ),
                            //                     Text(
                            //                       "2",
                            //                       style: TextStyle(
                            //                         color: e["isSelected"]
                            //                             ? Colors.white
                            //                             : Colors.black,
                            //                       ),
                            //                     )
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           )
                            //
                            //       )
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(
                              height: 18,
                            ),
                            BlocBuilder<ListOneHomeCubit, ListOneHomeState>(
                                builder: (context, lHState) {
                              if (lHState is ListOneHomeLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (lHState is ListOneHomeLoaded) {
                                List<ShowAdData> hOne =
                                    lHState.response?.data ?? [];
                                return Expanded(
                                    child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                      onTap:
                                          // hOne[index].status?.id == 2
                                          //     ? () {
                                          //         MyApplication.navigateTo(
                                          //             context,
                                          //             AdviceNewDetail(
                                          //                 id: hOne[index].id!));
                                          //       }
                                          //     :
                                          () {
                                        MyApplication.navigateTo(
                                            context,
                                            AdviceDetail(
                                              isAdviceDetail:
                                                  hOne[index].label!.id == 2,
                                              showAdData: hOne[index],
                                            ));
                                      },
                                      child: Advices(
                                        showAdData: hOne[index],
                                        isAdviceDetail: false,
                                      )),
                                  itemCount:
                                      lHState.response?.data?.length ?? 0,
                                ));
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else if (homeState is HomeStatusError) {
                return const Center(child: SizedBox());
              } else {
                return const Center(child: SizedBox());
              }
            }),
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
