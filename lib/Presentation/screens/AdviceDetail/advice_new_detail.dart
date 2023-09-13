import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/advice_cubits/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';

import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../Data/cubit/advice_cubits/approve_advice_cubit/approve_advice_cubit.dart';
import '../../../Data/cubit/advice_cubits/approve_advice_cubit/approve_advice_state.dart';
import '../../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_state.dart';
import '../../../Data/models/advice_models/advice_detail_model.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../app/utils/lang/language_constants.dart';

import '../../widgets/MyButton.dart';
import '../../widgets/MyButtonOutlined.dart';
import '../../widgets/noInternet.dart';
import '../../widgets/shared.dart';
import '../RegectOrder/RegectOrder.dart';
import 'advice_detail.dart';

class AdviceNewDetail extends StatefulWidget {
  const AdviceNewDetail({super.key, required this.id});
  final int id;

  @override
  State<AdviceNewDetail> createState() => _AdviceNewDetailState();
}

class _AdviceNewDetailState extends State<AdviceNewDetail> {
  final FocusNode _focusNode = FocusNode();

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

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
    context.read<ShowAdviceCubit>().show(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet showAdData else continue to the rest build code
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
        backgroundColor: Constants.whiteAppColor,
        body: BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
            builder: (context, showState) {
          if (showState is ShowAdviceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (showState is ShowAdviceLoaded) {
            ShowAdData showAdData = showState.response!.data!;
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyBackButton(),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(showAdData.client?.fullName ?? "",
                                  style: Constants.subtitleFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Text(
                                showAdData.date ?? "",
                                style: Constants.subtitleFont
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            logoColor,
                            color: Constants.primaryAppColor,
                            height: 50,
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 18, top: 14),
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
                              showAdData.name ?? "",
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
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(10),
                                        bottomStart: Radius.circular(10))),
                                child: Text(
                                  showAdData.status?.name ?? "",
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
                                            text: showAdData.price.toString(),
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
                                      child: BlocConsumer<ApproveAdviceCubit,
                                          ApproveAdviceState>(
                                        listener: (context, state) {
                                          if (state is ApproveAdviceLoaded) {
                                            ShowAdData stateData =
                                                state.response!.data!;
                                            MyApplication.navigateTo(
                                                context,
                                                AdviceDetail(
                                                  showAdData: stateData,
                                                ));
                                            MyApplication.showToastView(
                                                message: state.response?.data
                                                        ?.status?.name ??
                                                    "");
                                          }
                                        },
                                        builder: (context, state) => state
                                                is ApproveAdviceLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(end: 8.0),
                                                child: MyButton(
                                                  isBold: true,
                                                  txt: "قبول",
                                                  onPressedHandler: () {
                                                    context
                                                        .read<
                                                            ApproveAdviceCubit>()
                                                        .approve(showAdData.id!);
                                                  },
                                                ),
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
                                              RejectOrder(showAdData:showAdData,
                                              ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                width: 1, color: Constants.outLineColor)),
                        // ignore: prefer_const_literals_to_create_immutables
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 6, bottom: 6, left: 16, right: 16),
                            child: Text(
                              " showState.response.data.",
                              style: Constants.mainTitleRegularFont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ));
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
