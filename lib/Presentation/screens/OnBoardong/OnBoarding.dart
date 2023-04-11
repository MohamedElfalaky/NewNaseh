import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding();

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }, // hide keyboard on tap anywhere

      child: Stack(
        children: [
          Center(
            child: Image.asset(
              onBoardingPNGbk,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                  height: MyApplication.hightClc(context, 812),
                  // معدتش هتحتاجها الكونتينر بقى لعمل مارجن ف الاول بس لتخطيط الصفحة
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0, -4), end: Offset(0, 0.1))
                            .animate(_animationController),
                        child: SizedBox(
                            height: 150,
                            child: SvgPicture.asset(
                              onboardingImage,
                              // color: Colors.amber,
                            )),
                      ),
                      SizedBox(
                        height: 47,
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(-2, 0), end: Offset(0, 0))
                            .animate(_animationController),
                        child: Column(
                          children: [
                            Text(
                              "حياك الله بنصوح",
                              style: TextStyle(
                                  fontFamily: Constants.mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "مبدع في مجالك؟ عندك وقت تجاوب على أسئلة سريعة بمقابل مالي؟ حياك معنا",
                                style: Constants.mainTitleFont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "نصوح تطبيق يوفر إجابة وافية وسريعة لكل سؤال من خبراء ومختصين في جميع المجالات",
                                style: Constants.subtitleFont1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 48,
                        child: MyButton(
                          txt: "ابدأ الآن",
                          isBold: true,
                          onPressedHandler: () {
                            MyApplication.navigateToReplace(
                                context, const LoginScreen());
                          },
                        ),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
