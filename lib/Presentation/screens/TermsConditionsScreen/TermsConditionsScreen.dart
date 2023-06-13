import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen();

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
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
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
      MyApplication.showToastView(
          message: '${getTranslated(context, 'noInternet')}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                children: const [
                  Text("الشروط والأحكام"),
                ],
              ),
              leading: const MyBackButton()),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        termsConditions,
                        height: 40,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "الشروط والأحكام",
                            style: Constants.mainTitleFont,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            "آخر تحديث 12-10-2022",
                            style: Constants.subtitleRegularFont,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: ListView(
                    children: const [
                      Text(
                        "تقر بأن لديك الأهلية القانونية اللازمة للإبرام والموافقة على هذه الاتفاقية، وأن لديك الصلاحيات القانونية الكاملة غير المقيدة طبقًا للشروط التالية:\n(1) أهلية وموافقة الشخص الطبيعي\n1. يشترط في مُستخدِم تطبيق “يوما” أن يكون بلغ من العمر 18 عامًا فأكثر.\n2. يشترط في مستخدم تطبيق “يوما” أن يتوافر فيه الأهلية القانونية اللازمة لإبرام العقود، ونحن غير مسئولين عن التحقق من أهلية أيًا من مستخدمي الموقع.\n3. باستخدامك خدمات تطبيق “يوما” فأنت توافق على هذه الاتفاقية، وتقر بأنك ملزمًا قانونًا بالشروط والأحكام المنصوص عليها في هذه الوثيقة أو تعديلاتها.\n(2) أهلية وموافقة القاصر (من هم أقل من 18 عام)\n1. إذا كنت تحت سن 18 عامًا، يمكنك استخدام خدمات تطبيق “يوما” فقط تحت إشراف أحد الوالدين أو الوصي.\n2. مع عدم الإخلال بأي حقوق أخرى لتطبيق “يوما” بموجب هذه الاتفاقية أو القانون، يحتفظ التطبيق بالحق في تقييد وصولك إلى التطبيق أو إلغاء عضويتك إذا رأى أنك لم تبلغ سن 18 عامًا.\n(3) الصفة القانونية وموافقة المنشآت التجارية\nإذا كنت تسجل كمنشأة تجارية، فانك تقر بأن لديك سلطة إلزام هذه المنشأة باتفاقية المستخدم هذه، وأنك والمنشأة التجارية التي تمثلها سوف تخضعون لجميع القوانين السارية المتعلقة بالتداول عبر شبكة الانترنت.\nتقر بأن لديك الأهلية القانونية اللازمة للإبرام والموافقة على هذه الاتفاقية، وأن لديك الصلاحيات القانونية الكاملة غير المقيدة طبقًا للشروط التالية:\n(1) أهلية وموافقة الشخص الطبيعي\n1. يشترط في مُستخدِم تطبيق “يوما” أن يكون بلغ من العمر 18 عامًا فأكثر.\n2. يشترط في مستخدم تطبيق “يوما” أن يتوافر فيه الأهلية القانونية اللازمة لإبرام العقود، ونحن غير مسئولين عن التحقق من أهلية أيًا من مستخدمي الموقع.\n3. باستخدامك خدمات تطبيق “يوما” فأنت توافق على هذه الاتفاقية، وتقر بأنك ملزمًا قانونًا بالشروط والأحكام المنصوص عليها في هذه الوثيقة أو تعديلاتها.\n(2) أهلية وموافقة القاصر (من هم أقل من 18 عام)\n1. إذا كنت تحت سن 18 عامًا، يمكنك استخدام خدمات تطبيق “يوما” فقط تحت إشراف أحد الوالدين أو الوصي.\n2. مع عدم الإخلال بأي حقوق أخرى لتطبيق “يوما” بموجب هذه الاتفاقية أو القانون، يحتفظ التطبيق بالحق في تقييد وصولك إلى التطبيق أو إلغاء عضويتك إذا رأى أنك لم تبلغ سن 18 عامًا.\n(3) الصفة القانونية وموافقة المنشآت التجارية\nإذا كنت تسجل كمنشأة تجارية، فانك تقر بأن لديك سلطة إلزام هذه المنشأة باتفاقية المستخدم هذه، وأنك والمنشأة التجارية التي تمثلها سوف تخضعون لجميع القوانين السارية المتعلقة بالتداول عبر شبكة الانترنت.",
                        style: Constants.subtitleRegularFont,
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
