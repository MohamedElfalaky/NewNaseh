import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_cubit.dart';
import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_state.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_cubit.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../Data/models/rejection_models/list_rejection_model.dart';
import '../../../app/Style/Icons.dart';
import '../../widgets/alerts.dart';

class RejectOrder extends StatefulWidget {
  RejectOrder({required this.showAdData, super.key});

  ShowAdData? showAdData;

  @override
  State<RejectOrder> createState() => _RejectOrderState();
}

class _RejectOrderState extends State<RejectOrder> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  int? selectedId;

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<ListRejectionCubit>().getDataListRejection();
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
        context.read<ListRejectionCubit>().getDataListRejection();
      }
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
      MyApplication.showToastView(message: "noInternet".tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        }, // hide keyboard on tap anywhere

        child: Scaffold(
          floatingActionButton: BlocConsumer<PostRejectCubit, PostRejectState>(
            listener: (context, state) {
              if (state is PostRejectLoaded) {
                Alert.alert(
                    context: context,
                    action: () {
                      MyApplication.navigateToReplaceAllPrevious(
                          context, const HomeScreen());
                    },
                    content: "تم ارسال سبب الرفض بنجاح",
                    titleAction: "الرئيسية");
              }
            },
            builder: (context, state) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: state is PostRejectLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MyButton(
                        txt: "رفض الطلب",
                        isBold: true,
                        onPressedHandler: () {
                          context.read<PostRejectCubit>().postRejectMethod(
                                adviceId: widget.showAdData!.id.toString(),
                                commentId: selectedId.toString(),
                                commentOther: "",
                              );
                        },
                      )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: const Row(
                children: [
                  Text("رفض الطلب"),
                ],
              ),
              leading: MyBackButton()),
          body: BlocBuilder<ListRejectionCubit, ListRejectionState>(
              builder: (context, homeState) {
            if (homeState is ListRejectionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (homeState is ListRejectionLoaded) {
              final List<RejectData> list = homeState.response!.data!;
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Column(
                      children: [
                        Advices(
                          showAdData: widget.showAdData,
                          isAdviceDetail: false,
                        ),
                        TextField(
                          controller: _textController,
                          maxLines: 1,
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Constants.whiteAppColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Image.asset(
                                      rejeIcon,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          final object = list[index];
                                          return ListTile(
                                            leading: Radio(
                                              value: 1,
                                              groupValue: 0,
                                              onChanged: (val) {},
                                            ),
                                            title: Text(list[index].name!),
                                            onTap: () {
                                              Navigator.pop(
                                                  context); // Close the bottom sheet
                                              _textController.text =
                                                  list[index].name!;
                                              selectedId = list[index].id!;
                                              if (object.id == 0) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  backgroundColor:
                                                      Constants.whiteAppColor,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(25.0),
                                                    ),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return _otherBottom();
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          decoration:
                              Constants.setRegistrationTextInputDecoration(
                            // isParagraph: true,
                            hintText: "سبب الرفض",
                            prefixIcon: SvgPicture.asset(
                              rejectIcon,
                              color: const Color(0xffED2626),
                              height: 24,
                            ),

                            // const Icon(
                            //   Icons.remove_circle_outline_outlined,
                            //   color: Color(0xffED2626),
                            //   size: 24,
                            // ) ,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Constants.outLineColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            } else if (homeState is ListRejectionError) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          }),
        ));
  }

  Widget _otherBottom() {
    return SizedBox(
      height: height(context) * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                rejeIcon,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              Image.asset(
                rejeIcon,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              Image.asset(
                rejeIcon,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const Text(
            "سبب رفض الطلب",
            style: Constants.mainTitleFont,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              maxLines: 6,
              controller: _otherController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: Constants.setRegistrationTextInputDecoration(
                  isParagraph: true,
                  hintText: "اكتب سبب رفض الطلب...",
                  prefixIcon: SvgPicture.asset(
                    titleIcon,
                    height: 24,
                  )),
            ),
          ),
          BlocConsumer<PostRejectCubit, PostRejectState>(
            listener: (context, state) {
              if (state is PostRejectLoaded) {
                Alert.alert(
                    context: context,
                    action: () {
                      MyApplication.navigateToReplaceAllPrevious(
                          context, const HomeScreen());
                    },
                    content: "تم ارسال سبب الرفض بنجاح",
                    titleAction: "الرئيسية");
              }
            },
            builder: (context, state) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: state is PostRejectLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MyButton(
                        txt: "رفض الطلب",
                        isBold: true,
                        onPressedHandler: () {
                          context.read<PostRejectCubit>().postRejectMethod(
                                adviceId: widget.showAdData!.id.toString(),
                                commentId: "0",
                                commentOther: _otherController.text,
                              );
                        },
                      )),
          ),
        ],
      ),
    );
  }
}
