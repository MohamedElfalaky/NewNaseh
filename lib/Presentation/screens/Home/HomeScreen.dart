import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/Components/outComeandRate.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/screens/NotificationScreen/NotificationScreen.dart';
import 'package:nasooh/Presentation/screens/SettingsScreen/SettingsScreen.dart';
import 'package:nasooh/Presentation/screens/TermsConditionsScreen/TermsConditionsScreen.dart';
import 'package:nasooh/Presentation/screens/WalletScreen/WalletScreen.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';
import 'package:url_launcher/url_launcher.dart';

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
import '../EditProfileScreen/EditProfileScreen.dart';
import '../chat/chat_screen.dart';

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

  final controller = PageController(initialPage: 0);

  late ListOneHomeCubit homeCubit;
  Future<void> getDataFromApi() async {
    await context.read<HomeStatusCubit>().getDataHomeStatus();
    homeCubit.getOneHome("");
    context.read<GetUserCubit>().getUserMethod();
  }

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<ListOneHomeCubit>();
    getDataFromApi();


  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _focusNode.dispose();
    for (var element in homeController.categories) {
      element["isSelected"] = false;
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Constants.whiteAppColor,
          drawer: buildHomeDrawerWidget(context),
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
                          SvgPicture.asset(logoColor,
                              color: Colors.white, height: 60)
                        ],
                      ),
                    ),

                    Positioned(
                      top: MyApplication.hightClc(context, 160) - 25,
                      child: Container(
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
                              onChanged: (val) {
                                context
                                    .read<ListOneHomeCubit>()
                                    .getHomeSearch(name: val);
                              },
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
                                        assetName: ordersIcon,
                                        title: "عدد الطلبات",
                                        subtitle:
                                            "${18} ",
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
                                  return const SizedBox.shrink();
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
                            const SizedBox(height: 18),
                            BlocBuilder<ListOneHomeCubit, ListOneHomeState>(
                                builder: (context, state) {
                              if (state is ListOneHomeLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ListOneHomeLoaded) {
                                List<ShowAdData> homeData=[];

                                if(homeCubit.homeSearchList?.isEmpty==true) {
                                  homeData = state.response?.data ?? [];
                                } else {
                                  homeData=homeCubit.homeSearchList!;
                                }
                                return Expanded(
                                    child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        MyApplication.navigateTo(
                                            context,
                                            ChatScreen(
                                              isAdviceDetail:
                                                  homeData[index].label!.id ==
                                                      2,
                                              showAdData: homeData[index],
                                            ));
                                      },
                                      child: AdviceWidget(
                                        showAdData: homeData[index],
                                        isAdviceDetail: false,
                                      )),
                                  itemCount: homeData.length ,
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

  Drawer buildHomeDrawerWidget(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
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
                    const SizedBox(
                      width: 8,
                    ),
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
                MyApplication.navigateTo(
                    context, const TermsConditionsScreen());
              }),
          myListTile(
              icon: techIcon,
              name: "Tech".tr,
              onTapHandler: () async {
                await launchUrl(Uri.parse(
                  "whatsapp://send?phone=+966502374223",
                ));
                Navigator.pop(context);
              }),
          myListTile(icon: knowAboutIcon, name: "Know".tr),
          BlocBuilder<LogOutCubit, LogOutState>(
              builder: (context, state) => state is LogOutLoading
                  ? const Center(child: CircularProgressIndicator())
                  : myListTile(
                      icon: logOut,
                      name: "Sign Out".tr,
                      onTapHandler: () {
                        context.read<LogOutCubit>().logOut(
                              context: context,
                            );
                        // Navigator.pop(context);

                        // MyApplication.navigateTo(
                        //     context, const LoginScreen());
                      })),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 25),
            child: Text(
              "رقم الإصدار 1.0.0.1",
              style: Constants.subtitleFont,
            ),
          )
        ],
      ),
    );
  }

  ListTile myListTile(
      {required String icon, required String name, Function()? onTapHandler}) {
    return ListTile(
        minLeadingWidth: 10,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        leading: SvgPicture.asset(icon, color: const Color(0XFF5C5E6B)),
        title: Text(
          name,
          style: Constants.secondaryTitleRegularFont
              .copyWith(color: const Color(0XFF5C5E6B)),
        ),
        onTap: onTapHandler);
  }
}
