import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/RegectOrder/RegectOrder.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/MyButtonOutlined.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class Advices extends StatelessWidget {
  bool? isAdviceDetail;
  final String price;

  final String title;
  final String date;
  final String status;
  final String advisedName;
  final String advisedPhoto;

  Advices(
      {super.key,
      this.isAdviceDetail,
      required this.advisedPhoto,
      required this.price,
      required this.title,
      required this.date,
      required this.status,
      required this.advisedName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 1, color: Constants.primaryAppColor.withOpacity(0.1))),
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
          child: Text(
            title,
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
                  date,
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
                status,
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
                          text: price,
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
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8.0),
                          child: MyButton(
                            isBold: true,
                            txt: "تسليم",
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
                            MyApplication.navigateTo(context, RegectOrder());
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
                      child: advisedPhoto == ""
                          ? SvgPicture.asset(
                              logotrans,
                              height: 28,
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(advisedPhoto),
                            ),
                    ),
                    Padding(
                        padding: const EdgeInsetsDirectional.only(start: 6),
                        child: Text(
                          advisedName,
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
