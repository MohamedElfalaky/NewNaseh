import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage2/RegistrationStage2.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/utils/lang/language_constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../widgets/PhoneTextField.dart';

class RegistrationStage1 extends StatefulWidget {
  const RegistrationStage1({Key? key}) : super(key: key);

  @override
  State<RegistrationStage1> createState() => _RegistrationStage1State();
}

class _RegistrationStage1State extends State<RegistrationStage1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leadingWidth: 70,
            title: const Text("إنشاء حساب ناصح"),
            leading: const myBackButton()),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MyApplication.hightClc(context, 88),
                          top: MyApplication.hightClc(context, 74)),
                      child: const Center(
                          child: Text(
                        "إنشاء حساب جديد",
                        style: TextStyle(
                            fontFamily: Constants.mainFont, fontSize: 24),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MyApplication.hightClc(context, 8)),
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
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: MyButton(
                        isBold: true,
                        txt: "إرسال رمز التحقق",
                        onPressedHandler: () {
                          if (_formKey.currentState!.validate()) {
                            MyApplication.navigateTo(
                                context, RegistrationStage2());
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 40),
                      child: Text(
                        "خطوة 1 من 7",
                        style: Constants.subtitleFont,
                      ),
                    ),
                    const Text(
                      "بالاستمرار أنت توافق على",
                      style: Constants.secondaryTitleRegularFont,
                    ),
                    const Text("سياسة الخصوصية والاستخدام",
                        style: Constants.mainTitleFont),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MyApplication.hightClc(context, 110)),
                      child: const Text("لديك حساب بالفعل",
                          style: Constants.subtitleFont1),
                    ),
                    InkWell(
                      onTap: () =>
                          MyApplication.navigateTo(context, LoginScreen()),
                      child: const Text(
                        "تسجيل دخول",
                        style: Constants.secondaryTitleFont,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
