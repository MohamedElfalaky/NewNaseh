import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage1/RegistrationStage1.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/PhoneTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _fadeController;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animationController.forward();

    _fadeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _fadeController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
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
          // Center(
          //   child: SvgPicture.asset(
          //     backgroundddd,
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Scaffold(
            backgroundColor: const Color.fromARGB(0, 168, 46, 46),
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                  top: 16,
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(0, -3), end: Offset(0, 0.1))
                              .animate(_animationController),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24, top: 44),
                            child: Center(
                              child: SvgPicture.asset(
                                soNew,
                                width: 148,
                                height: 148,
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "تسجيل الدخول",
                            style: Constants.headerNavigationFont,
                          ),
                        ),
                        FadeTransition(
                          opacity: _fadeController,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 34, bottom: 10),
                            child: MyIntlPhoneField(
                              countries: ['SA'],
                              controller: _phoneController,
                              showDropdownIcon: true,
                              dropdownIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.transparent,
                                size: 6,
                              ),
                              style: Constants.subtitleFont1,
                              // dropdownIconPosition: IconPosition.trailing,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "رقم الجوال...",
                                hintStyle: Constants.subtitleRegularFontHint,
                                errorStyle: Constants.subtitleFont1.copyWith(
                                  color: Colors.red,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 0,
                                  borderSide: const BorderSide(
                                    color: Color(0xff808488),
                                  ),
                                ),
                              ),
                              initialCountryCode: 'SA',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                              invalidNumberMessage:
                                  getTranslated(context, "invalid_number")!,
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _fadeController,
                          child: PasswordTextFormField(
                              style: Constants.subtitleFont1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, "password_required")!;
                                }
                                if (value.length < 6) {
                                  return getTranslated(
                                      context, "password_length")!;
                                }
                                return null;
                              },
                              decoration: Constants.setTextInputDecoration(
                                  hintText: "كلمة المرور...",
                                  prefixIcon: Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Color(0xFFBDBDBD)))),
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 8),
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 8),
                                    child: SvgPicture.asset(
                                      passField,
                                      height: 24,
                                    ),
                                  ))),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 30),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         height: 24,
                        //         width: 30,
                        //         child: Checkbox(
                        //           value: false,
                        //           onChanged: (value) {},
                        //         ),
                        //       ),
                        //       const Text(
                        //         "تذكر معلوماتي",
                        //         style: Constants.secondaryTitleRegularFont,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 24,
                        ),
                        FadeTransition(
                          opacity: _fadeController,
                          child: SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: MyButton(
                              isBold: true,
                              txt: "تسجيل الدخول",
                              onPressedHandler: () {
                                if (_formKey.currentState!.validate()) {
                                  MyApplication.navigateTo(
                                      context, RegistrationStage1());
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        FadeTransition(
                          opacity: _fadeController,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                                getTranslated(context, "forgot_password")!,
                                textAlign: TextAlign.center,
                                style: Constants.mainTitleFont),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const SizedBox(
                            width: double.infinity,
                            child: Text("ماعندك حساب؟",
                                textAlign: TextAlign.center,
                                style: Constants.subtitleFont1)),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () => MyApplication.navigateTo(
                                context, RegistrationStage1()),
                            child: Text(
                              "سجل معنا",
                              style: Constants.secondaryTitleFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        // Center(
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width * 0.3,
                        //     child: ElevatedButton(
                        //       onPressed: () {},
                        //       child: Center(
                        //         child: Text(
                        //           getTranslated(context, "login_guest")!,
                        //           style: Constants.secondaryTitleRegularFont.copyWith(
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
