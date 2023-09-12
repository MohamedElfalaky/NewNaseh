import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/lang/language_constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../../app/utils/registeration_values.dart';
import '../../../../Data/cubit/authentication/forget_password_cubit/forget_mob/forget_mob_cubit.dart';
import '../../../../Data/cubit/authentication/forget_password_cubit/forget_mob/forget_mob_state.dart';
import '../../../widgets/PhoneTextField.dart';
import 'check_forget_code_screen.dart';

String ?forgetMob;

class CheckForgetMobile extends StatefulWidget {
  const CheckForgetMobile({Key? key}) : super(key: key);

  @override
  State<CheckForgetMobile> createState() => _CheckForgetMobileState();
}

class _CheckForgetMobileState extends State<CheckForgetMobile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  String _sendPhone = "";

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
            title: const Text("تغير كلمة المرور"),
            leading:  MyBackButton()),
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
                child: BlocBuilder<CheckCheckMobCubit, CheckMobState>(
                    builder: (context, state) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MyApplication.hightClc(context, 88),
                                  top: MyApplication.hightClc(context, 74)),
                              child: const Center(
                                  child: Text(
                                "من فضلك ادخل رقم جوالك لتأكيد الحساب و ارسال رمز التحقق",
                                style: TextStyle(
                                    fontFamily: Constants.mainFont,
                                    fontSize: 18),
                              )),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "رقم الجوال",
                                textAlign: TextAlign.start,
                                style: Constants.mainTitleRegularFont
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MyApplication.hightClc(context, 10),
                                  bottom: MyApplication.hightClc(context, 50)),
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
                                    borderRadius: BorderRadius.circular(10),
                                    gapPadding: 0,
                                    borderSide: const BorderSide(
                                      color: Color(0xff808488),
                                    ),
                                  ),
                                ),
                                initialCountryCode: 'SA',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                  _sendPhone = phone.completeNumber;
                                },
                                invalidNumberMessage:
                                    getTranslated(context, "invalid_number")!,
                              ),
                            ),
                            state is CheckMobLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: MyButton(
                                      isBold: true,
                                      txt: "التالي",
                                      onPressedHandler: () {
                                        // if (_formKey.currentState!.validate()) {
                                        //   context.read<CheckCheckMobCubit>().register(
                                        //       context: context,
                                        //       phone: _sendPhone);
                                          forgetMob = _sendPhone;
                                        // }
                                         MyApplication.navigateTo(context, const CheckForgetCode());
                                      },
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MyApplication.hightClc(context, 110)),
                              child: const Text("يوجد لديك حساب",
                                  style: Constants.subtitleFont1),
                            ),
                            InkWell(
                              onTap: () => MyApplication.navigateTo(
                                  context, const LoginScreen()),
                              child: const Text(
                                "تسجيل دخول",
                                style: Constants.secondaryTitleFont,
                              ),
                            ),
                          ],
                        ))),
          ),
        ),
      ),
    );
  }
}
