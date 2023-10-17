import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_cubit.dart';
import '../../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_state.dart';
import '../../../Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import '../../../Data/cubit/send_chat_cubit/send_chat_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../widgets/noInternet.dart';
import '../../widgets/shared.dart';

class AdviceDetail extends StatefulWidget {
  AdviceDetail({super.key, required this.showAdData});

  ShowAdData? showAdData;

  @override
  State<AdviceDetail> createState() => _AdviceDetailState();
}

class _AdviceDetailState extends State<AdviceDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  String? fileSelected;
  File? pickedFile;

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<ShowAdviceCubit>().show(id: widget.showAdData!.id!);
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
        context.read<ShowAdviceCubit>().show(id: widget.showAdData!.id!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _focusNode.dispose();
    subscription.cancel();
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
      MyApplication.showToastView(message: "noInternet".tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        }, // hide keyboard on tap anywhere

        child: MultiBlocListener(
          listeners: [
            BlocListener<SendChatCubit, SendChatState>(
              listener: (context, state) {
                // TODO: implement listener

                if (state is SendChatLoaded) {
                  context
                      .read<ShowAdviceCubit>()
                      .show(id: widget.showAdData!.id!);
                  _textController.clear();
                }
              },
            ),
            BlocListener<ShowAdviceCubit, ShowAdviceState>(
              listener: (context, state) {
                if (state is ShowAdviceLoaded) {
                  // _textController.clear();

                  AudioPlayer().play(AssetSource("click.wav"));
                }
              },
            ),
          ],
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
              body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Advices(
                            showAdData: widget.showAdData,
                            isAdviceDetail: true,
                          ),
                        ),
                        Expanded(
                            child:
                                BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                          buildWhen: (previous, current) {
                            return current is! ShowAdviceLoading;
                          },
                          builder: (context, state) {
                            if (state is ShowAdviceLoaded) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView.builder(
                                  reverse: true,
                                  itemCount: state.response!.data!.chat!.length,
                                  itemBuilder: (context, index) => Align(
                                    alignment: state.response!.data!
                                                .chat![index].client ==
                                            null
                                        ? AlignmentDirectional.centerStart
                                        : AlignmentDirectional.centerEnd,
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 220),
                                      // width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      padding: const EdgeInsets.all(8),
                                      // constraints: BoxConstraints(mi),
                                      decoration: BoxDecoration(
                                          color: state.response!.data!
                                                      .chat![index].client ==
                                                  null
                                              ? const Color.fromARGB(
                                                      255, 185, 184, 180)
                                                  .withOpacity(0.2)
                                              : Constants.primaryAppColor
                                                  .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        state.response!.data!.chat![index]
                                            .message
                                            .toString(),
                                        style: Constants.subtitleFont,
                                        // textAlign: state.response!.data!
                                        //             .chat![index].client ==
                                        //         null
                                        //     ? TextAlign.start
                                        //     : TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is ShowAdviceError) {
                              return const Center(
                                child: Text("Error"),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        )),

                        widget.showAdData!.label!.id == 1 ||
                                widget.showAdData!.label!.id == 2
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                  left: 16,
                                  right: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _textController,
                                        focusNode: _focusNode,
                                        decoration:
                                            Constants.setTextInputDecoration(
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles();
                                                    // type:
                                                    // FileType.custom;
                                                    // allowedExtensions:
                                                    // ['pdf', 'jpg', 'png', "doc", "docx", "gif"];
                                                    if (result != null) {
                                                      setState(() {
                                                        pickedFile = File(result
                                                            .files
                                                            .single
                                                            .path!);
                                                      });
                                                      List<int> imageBytes =
                                                          await File(pickedFile!
                                                                  .path)
                                                              .readAsBytesSync();
                                                      // print(imageBytes);
                                                      fileSelected = base64
                                                          .encode(imageBytes);
                                                    }
                                                    return;
                                                  },
                                                  child: SvgPicture.asset(
                                                      attachFiles)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              SvgPicture.asset(micee),
                                              const SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                          hintText: "آكتب رسالتك...",
                                        ).copyWith(
                                          hintStyle: Constants
                                              .subtitleRegularFontHint
                                              .copyWith(
                                                  color:
                                                      const Color(0XFF5C5E6B)),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                    BlocBuilder<ShowAdviceCubit,
                                        ShowAdviceState>(
                                      builder: (context, state2) {
                                        return BlocBuilder<SendChatCubit,
                                            SendChatState>(
                                          builder: (context, state3) {
                                            return InkWell(
                                              onTap: () {
                                                if (state2
                                                        is ShowAdviceLoading ||
                                                    state3 is SendChatLoading) {
                                                  return;
                                                }

                                                MyApplication.dismissKeyboard(
                                                    context);

                                                MyApplication.checkConnection()
                                                    .then((value) {
                                                  if (fileSelected != null) {
                                                    context
                                                        .read<SendChatCubit>()
                                                        .sendChatFunction(
                                                        filee:
                                                        fileSelected,
                                                        msg:
                                                        pickedFile!
                                                            .path.split("/").last,
                                                        adviceId: widget
                                                            .showAdData!
                                                            .id
                                                            .toString());
                                                    print("new");
                                                    print(fileSelected);
                                                  } else if (value) {
                                                    if (_textController
                                                        .text.isEmpty) {
                                                      MyApplication.showToastView(
                                                          message:
                                                              "لا يمكن ارسال رسالة فارغة!");
                                                    } else {
                                                      context
                                                          .read<SendChatCubit>()
                                                          .sendChatFunction(
                                                              filee:
                                                                  fileSelected,
                                                              msg:
                                                                  _textController
                                                                      .text,
                                                              adviceId: widget
                                                                  .showAdData!
                                                                  .id
                                                                  .toString());
                                                    }
                                                  } else {
                                                    MyApplication.showToastView(
                                                        message:
                                                            "لا يوجد اتصال");
                                                  }
                                                });
                                              },
                                              child:
                                                  //  state is ShowAdviceLoading
                                                  //     ? Center(
                                                  //         child: CircularProgressIndicator(),
                                                  //       )
                                                  //     :
                                                  Container(
                                                      margin:
                                                          const EdgeInsetsDirectional
                                                              .only(start: 8),
                                                      padding: const EdgeInsets
                                                          .all(10),
                                                      height: 40,
                                                      width: 40,
                                                      decoration: state3
                                                              is SendChatLoading
                                                          ? BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Colors
                                                                  .grey)
                                                          : BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: const Color(
                                                                  0XFF273043)),
                                                      child: SvgPicture.asset(
                                                        sendChat,
                                                        color: state3
                                                                is SendChatLoading
                                                            ? const Color
                                                                .fromARGB(
                                                                255, 57, 53, 53)
                                                            : null,
                                                      )),
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: 90,
                                width: width(context),
                                color:
                                    Constants.primaryAppColor.withOpacity(0.1),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "لا يمكنك التحدث مع هذا المنصوح الان",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: Constants.mainFont),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        MyApplication.navigateTo(
                                            context, const HomeScreen());
                                      },
                                      child: const Text(
                                        "العودة الي الرئيسة",
                                        style: TextStyle(
                                            color: Constants.primaryAppColor,
                                            fontFamily: Constants.mainFont),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 12),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: TextField(
                        //           controller: _textController,
                        //           focusNode: _focusNode,
                        //           decoration:
                        //               Constants.setTextInputDecoration(
                        //             suffixIcon: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 SvgPicture.asset(attachFiles),
                        //                 SizedBox(
                        //                   width: 8,
                        //                 ),
                        //                 SvgPicture.asset(micee),
                        //                 SizedBox(
                        //                   width: 8,
                        //                 )
                        //               ],
                        //             ),
                        //             hintText: "آكتب رسالتك...",
                        //           ).copyWith(
                        //             hintStyle: Constants
                        //                 .subtitleRegularFontHint
                        //                 .copyWith(color: Color(0XFF5C5E6B)),
                        //             enabledBorder: const OutlineInputBorder(
                        //               gapPadding: 0,
                        //               borderSide: BorderSide.none,
                        //               borderRadius: BorderRadius.all(
                        //                 Radius.circular(25),
                        //               ),
                        //             ),
                        //             filled: true,
                        //             fillColor: const Color(0xffF5F4F5),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //           margin:
                        //               EdgeInsetsDirectional.only(start: 8),
                        //           padding: EdgeInsets.all(10),
                        //           height: 40,
                        //           width: 40,
                        //           decoration: BoxDecoration(
                        //               borderRadius:
                        //                   BorderRadius.circular(15),
                        //               color: Color(0XFF273043)),
                        //           child: SvgPicture.asset(
                        //             sendChat,
                        //           ))
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ))),
        ));
  }
}
