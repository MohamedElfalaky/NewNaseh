import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:lottie/lottie.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:pinput/pinput.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../Data/cubit/authentication/forget_password_cubit/check_forget_code_cubit/check_code_cubit.dart';
import '../../../../Data/cubit/authentication/forget_password_cubit/check_forget_code_cubit/check_code_state.dart';
import 'check_mobile_forget_screen.dart';

class CheckForgetCode extends StatefulWidget {
  const CheckForgetCode({Key? key}) : super(key: key);

  @override
  State<CheckForgetCode> createState() => _CheckForgetCodeState();
}

class _CheckForgetCodeState extends State<CheckForgetCode> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  late CountdownTimerController timerController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late FocusNode myFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();

    timerController = CountdownTimerController(endTime: endTime, onEnd: () {});
  }

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
              title: const Text("إدخال رمز التحقق"),
              leading: MyBackButton()),
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
                child: BlocBuilder<CheckForgetCodeCubit, ForgetCodeState>(
                    builder: (context, state) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(otpLotti, height: 160),
                            const Text(
                              "رمز التحقق من الجوال",
                              style: TextStyle(
                                  fontFamily: Constants.mainFont, fontSize: 24),
                            ),
                            const Text(
                              "تم إرسال رمز التحقق إلى رقم جوالك",
                              style: Constants.subtitleFont1,
                            ),
                            Text(
                              " $forgetMob",
                              style: Constants.secondaryTitleRegularFont,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MyApplication.hightClc(context, 30),
                                    bottom:
                                        MyApplication.hightClc(context, 32)),
                                child: Pinput(
                                  errorTextStyle: Constants.subtitleFont
                                      .copyWith(color: Colors.red),
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  autofocus: true,
                                  controller: _pinController,
                                  focusNode: myFocusNode,
                                  defaultPinTheme: Constants.defaultPinTheme,
                                  focusedPinTheme: Constants.focusedPinTheme,
                                  errorPinTheme: Constants.errorPinTheme,
                                  // errorBuilder: (errorText, pin) {},
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value.length != 4 ||
                                        !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return "يرجى ادخال رمز تحقق صحيح";
                                    }
                                    return null;
                                  },
                                 ),
                              ),
                            ),
                            state is ForgetCodeLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: MyButton(
                                      isBold: true,
                                      txt: "التالي",
                                      onPressedHandler: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<CheckForgetCodeCubit>()
                                              .checkCodeMethod(
                                                context: context,
                                                code: _pinController.text,
                                              );
                                        }
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "سيتم اعادة ارسال الكود بعد ",
                                  style: Constants.subtitleRegularFont,
                                ),
                                CountdownTimer(
                                  controller: timerController,
                                  widgetBuilder: (_, time) {
                                    if (time == null) {
                                      return Text(
                                        '00:00',
                                        style: Constants.subtitleRegularFont
                                            .copyWith(
                                                color:
                                                    Constants.primaryAppColor),
                                      );
                                    }
                                    return Text(
                                      '${time.min ?? "00"}:${time.sec}',
                                      style: Constants.subtitleRegularFont
                                          .copyWith(
                                              color: Constants.primaryAppColor),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MyApplication.hightClc(context, 40)),
                              child: const Text("لم تستلم الرمز حتى الآن",
                                  style: Constants.subtitleFont1),
                            ),
                            const Text(
                              "إعادة إرسال",
                              style: Constants.mainTitleFont,
                            ),
                          ],
                        )),
              ),
            ),
          ),
        ));
  }
}
