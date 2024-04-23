import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Components/advice_widget.dart';
import 'package:nasooh/Presentation/screens/Home/Components/outcome_and_rate.dart';
import 'package:nasooh/Presentation/screens/Home/controller/home_controller.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
import 'package:nasooh/app/utils/shared_preference.dart';

import '../../../Data/cubit/authentication/get_user_cubit/get_user_cubit.dart';
import '../../../Data/cubit/authentication/get_user_cubit/get_user_state.dart';
import '../../../Data/cubit/home/home_one_cubit/home_one_cubit.dart';
import '../../../Data/cubit/home/home_one_cubit/home_one_state.dart';
import '../../../Data/cubit/home/home_status_cubit/home_status_cubit.dart';
import '../../../Data/cubit/home/home_status_cubit/home_status_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../Data/models/home_models/home_status_model.dart';
import '../../../app/styles/icons.dart';
import '../../widgets/custom_loading_widget.dart';
import '../chat/chat_screen.dart';
import 'Components/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? ordersCount = null;
  HomeController homeController = HomeController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late ListOneHomeCubit homeCubit;

  Future<void> getDataFromApi() async {
    await context.read<HomeStatusCubit>().getDataHomeStatus();
    homeCubit.getOneHome("");
    if (mounted) {
      context.read<GetUserCubit>().getUserMethod();
    }
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
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Constants.whiteAppColor,
        drawer: buildHomeDrawerWidget(context),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<HomeStatusCubit, HomeStatusState>(
              builder: (context, homeState) {
            if (homeState is HomeStatusLoading) {
              return const CustomLoadingIndicator();
            } else if (homeState is HomeStatusLoaded) {
              final List<Datum> dataList = homeState.response?.data ?? [];
              return Stack(
                children: [
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
                                _focusNode.unfocus(); // Unfocus the text field
                              }
                            }),
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
                            colorFilter: getFilterColor(Colors.white),
                            height: 60)
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
                            onTap: ()=>MyApplication.unFocusCursorRTL(_textController),
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
                                  color:
                                      const Color(0xff0085A5).withOpacity(0.25),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 32),
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
                                      subtitle: "${ordersCount??0} ",
                                      color: Constants.primaryAppColor,
                                    ),
                                    OutcomeAndRate(
                                      assetName: starIcon,
                                      title: "التقييم الإجمالي",
                                      subtitle:
                                          stateUser.response?.data?.rate ?? "0",
                                      color: const Color(0xFF27AE60),
                                    )
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
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
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 8),
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? Constants.primaryAppColor
                                          : Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15)),
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
                                                fontFamily: Constants.mainFont,
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
                          BlocConsumer<ListOneHomeCubit, ListOneHomeState>(
                              listener: (context, state) {
                            if (state is ListOneHomeLoaded) {
                              if(ordersCount==null) {
                                ordersCount = state.response?.data?.length ?? 0;
                                setState(() {});
                              }
                            }
                          }, builder: (context, state) {
                            if (state is ListOneHomeLoading) {
                              return const CustomLoadingIndicator();
                            } else if (state is ListOneHomeLoaded) {
                              List<ShowAdData> homeData = [];

                              if (homeCubit.homeSearchList?.isEmpty == true) {
                                homeData = state.response?.data ?? [];
                              } else {
                                homeData = homeCubit.homeSearchList ?? [];
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
                                                homeData[index].label!.id == 2,
                                            showAdData: homeData[index],
                                          ));
                                    },
                                    child: AdviceWidget(
                                      showAdData: homeData[index],
                                      isAdviceDetail: false,
                                    )),
                                itemCount: homeData.length,
                              ));
                            }
                            return const SizedBox.shrink();
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
