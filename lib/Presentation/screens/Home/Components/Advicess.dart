import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/advice_cubits/done_advice_cubit/done_advice_cubit.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/screens/RegectOrder/RegectOrder.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/MyButtonOutlined.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../../Data/cubit/advice_cubits/done_advice_cubit/done_advice_state.dart';
import '../../../../Data/models/advice_models/show_advice_model.dart';
import '../../../widgets/alerts.dart';

class Advices extends StatelessWidget {
  bool? isAdviceDetail;
  ShowAdData? showAdData;

  Advices({super.key, this.isAdviceDetail, required this.showAdData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 1,
              color: isAdviceDetail == true
                  ? Constants.primaryAppColor
                  : Constants.primaryAppColor.withOpacity(0.1))),
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
          child: Text(
            showAdData?.name ?? "",
            style: Constants.mainTitleFont,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isAdviceDetail != true)
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16),
                child: Text(
                  showAdData?.date ?? "",
                  style: Constants.subtitleRegularFont,
                ),
              ),
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
                showAdData?.status?.name ?? "",
                style: TextStyle(fontSize: 10, fontFamily: Constants.mainFont),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              SvgPicture.asset(nasehaCost),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 6),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: showAdData?.price.toString() ?? "",
                          style: Constants.headerNavigationFont.copyWith(
                              fontSize: 20, color: Constants.primaryAppColor)),
                      TextSpan(
                          text: 'ريال سعودي',
                          style: Constants.subtitleFontBold
                              .copyWith(color: Constants.primaryAppColor)),
                    ],
                  ),
                ),
              )
              // Text("75 ريال سعودي",style: ,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
          child: DottedLine(
            dashColor: const Color(0xff0085A5).withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: isAdviceDetail == true
              ? SizedBox(
                  child: Row(
                    children: [
                      BlocConsumer<DoneAdviceCubit, DoneAdviceState>(
                        listener: (context, state) {
                          if (state is DoneAdviceLoaded) {
                            Alert.alert(context: context , action: (){
                              MyApplication.navigateTo(context, const HomeScreen());
                            } ,content:"تم تسليم نصيحتك بنجاح" ,titleAction: "الرئيسية" );

                          }
                        },
                        builder: (context, state) => Flexible(
                          flex: 2,
                          child: state is DoneAdviceLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 8.0),
                                  child: MyButton(
                                    isBold: true,
                                    txt: "تسليم",
                                    onPressedHandler: () {
                                      context
                                          .read<DoneAdviceCubit>()
                                          .done(adviceId: showAdData!.id!);
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
                                context, RejectOrder(showAdData: showAdData));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(color: Constants.primaryAppColor)),
                      child: showAdData?.client?.avatar == ""
                          ? SvgPicture.asset(
                              logotrans,
                              height: 28,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(showAdData!.client!.avatar!),
                            ),
                    ),
                    Padding(
                        padding: const EdgeInsetsDirectional.only(start: 6),
                        child: Text(
                          showAdData!.client!.fullName!,
                          style: Constants.subtitleFont,
                        ))
                    // Text("75 ريال سعودي",style: ,)
                  ],
                ),
        ),
      ]),
    );
  }
}
