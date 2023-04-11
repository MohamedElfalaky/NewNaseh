import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class AdviceDetailController {
  ///vars
  List<Map> categories = [
    {"name": "الكل", "isSelected": true},
    {"name": "الجديدة", "isSelected": false},
    {"name": "قيد التنفيذ", "isSelected": false},
    {"name": "الملغية", "isSelected": false},
    {"name": "المكتملة", "isSelected": false},
  ];

  ///methods
  // void AdviceDetailAPIs(BuildContext context, String token) async {
  //   final bool result = await MyApplication.checkInternet();
  //   if (!result) {
  //     MyApplication.showToast(
  //         text: "No Internet connection | لا يوجد اتصال",
  //         color: ToastColors.error);
  //   } else {
  //     // AdviceDetailItemsCubit.get(context).getAdviceDetailItems(token);
  //     // TotalFeeCubit.get(context).getTotalFee(token);
  //   }
  // }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget pageViewItem() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "ابحث عن ناصح",
                  style: TextStyle(
                      color: Constants.primaryAppColor,
                      fontSize: 16,
                      fontFamily: Constants.mainFont,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    textAlign: TextAlign.right,
                    "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحةما سيلهي القارئ عن التركيز على الشكل.",
                    style:
                        TextStyle(fontSize: 10, fontFamily: Constants.mainFont),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: SvgPicture.asset(
                tempPic,
                height: 100,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
