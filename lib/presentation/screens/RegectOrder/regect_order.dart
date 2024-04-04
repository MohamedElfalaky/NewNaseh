import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/Home/Components/advice_widget.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/Presentation/widgets/custom_button.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';

import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_cubit.dart';
import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_state.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_cubit.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../../Data/models/rejection_models/list_rejection_model.dart';
import '../../../app/styles/icons.dart';
import '../../widgets/alerts.dart';
import '../../widgets/custom_loading_widget.dart';

class RejectOrder extends StatefulWidget {
  const RejectOrder({required this.showAdData, super.key});

  final ShowAdData? showAdData;

  @override
  State<RejectOrder> createState() => _RejectOrderState();
}

class _RejectOrderState extends State<RejectOrder> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  dynamic selectedId;

  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    context.read<ListRejectionCubit>().getDataListRejection();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
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
                    ? const CustomLoadingIndicator()
                    : CustomButton(
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
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: const Row(
                children: [
                  Text("رفض الطلب"),
                ],
              ),
              leading: CustomBackButton()),
          body: BlocBuilder<ListRejectionCubit, ListRejectionState>(
              builder: (context, homeState) {
            if (homeState is ListRejectionLoading) {
              return const CustomLoadingIndicator();
            } else if (homeState is ListRejectionLoaded) {
              final List<RejectData> list = homeState.response!.data!;
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  children: [
                    AdviceWidget(
                      showAdData: widget.showAdData,
                      isAdviceDetail: false,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    rejeIcon,
                                    height: 100,
                                    width: 100,
                                    // fit: BoxFit.cover,
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        final object = list[index];
                                        return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: Radio(
                                            value: 1,
                                            groupValue: 0,
                                            onChanged: (val) {},
                                          ),
                                          title: Text(
                                            list[index].name!,
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                                    top: Radius.circular(25.0),
                                                  ),
                                                ),
                                                builder:
                                                    (BuildContext context) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: SingleChildScrollView(
                                                        child:
                                                            otherBottomSheet()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        autofocus: false,
                        enabled: false,
                        cursorHeight: 0,
                        decoration:
                            Constants.setRegistrationTextInputDecoration(
                          hintText: "سبب الرفض",
                          prefixIcon: SvgPicture.asset(
                            rejectIcon,
                            colorFilter: getFilterColor(Colors.red),
                            height: 24,
                          ),
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                        ).copyWith(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black45,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }

  Widget otherBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
        ),
      ),
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
          BlocBuilder<PostRejectCubit, PostRejectState>(
            builder: (context, state) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 50,
                child: state is PostRejectLoading
                    ? const CustomLoadingIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomButton(
                          txt: "رفض  الطلب",
                          isBold: true,
                          onPressedHandler: () {
                            context.read<PostRejectCubit>().postRejectMethod(
                                  adviceId: widget.showAdData!.id.toString(),
                                  commentId: "0",
                                  commentOther: _otherController.text,
                                );
                          },
                        ),
                      )),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
