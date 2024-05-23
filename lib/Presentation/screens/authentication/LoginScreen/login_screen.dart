import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/authentication/login_cubit/login_cubit.dart';
import 'package:nasooh/Data/cubit/authentication/login_cubit/login_state.dart';
import 'package:nasooh/Presentation/widgets/custom_button.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/styles/icons.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/custom_loading_widget.dart';
import '../../../widgets/phone_textfield.dart';
import '../ChangePassword/check_mobile_forget_screen.dart';
import '../RegistrationCycle/RegistrationStage1/registration_stage1.dart';
import '../RegistrationCycle/registration_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animationController.forward();

    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeController.forward();
  }

  String _sendPhone = "";

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _fadeController.dispose();
  }

  bool valueChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              onBoardingPNGbk,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(0, -3),
                                end: const Offset(0, 0.1))
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
                          "تسجيل دخول",
                          style: Constants.headerNavigationFont,
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeController,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 34, bottom: 10),
                          child: MyIntlPhoneField(
                            countries: const ['SA'],
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
                              _sendPhone = phone.completeNumber;
                            },
                            invalidNumberMessage: "invalid_number".tr,
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeController,
                        child: PasswordTextFormField(
                            maxLength: 12,
                            controller: _passwordController,
                            style: Constants.subtitleFont1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password_required".tr;
                              } else if (value.length < 8 || value.length > 12) {
                                return "password_length".tr;
                              }

                              // Enhanced regular expression for password complexity (optional symbol)
                              RegExp regex = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)(?:.*[@$!%*?&])?[A-Za-z\d@$!%*?&]+$');
                              if (!regex.hasMatch(value)) {
                                return 'يجب أن تحتوي كلمة المرور على حرف كبير وحرف صغير ورقم (الرمز اختياري)';
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
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 8),
                                  padding: const EdgeInsetsDirectional.all(8),
                                  child: SvgPicture.asset(
                                    passField,
                                    height: 24,
                                  ),
                                ))),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Text(
                          "تذكر معلوماتي",
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        value: valueChanged,
                        onChanged: (bool? value) {
                          setState(() {
                            valueChanged = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      state is LoginLoading
                          ? const CustomLoadingIndicator()
                          : FadeTransition(
                              opacity: _fadeController,
                              child: SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: CustomButton(
                                  isBold: true,
                                  txt: "تسجيل الدخول",
                                  onPressedHandler: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().login(
                                          context: context,
                                          pass: _passwordController.text,
                                          phone: _sendPhone);
                                    }
                                  },
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 32,
                      ),
                      InkWell(
                        onTap: () => MyApplication.navigateTo(
                            context, const CheckForgetMobile()),
                        child: FadeTransition(
                          opacity: _fadeController,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("forgot_password".tr,
                                textAlign: TextAlign.center,
                                style: Constants.mainTitleFont),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 85,
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
                              context, const RegistrationStage1()),
                          child: const Text(
                            "سجل معنا",
                            style: Constants.secondaryTitleFont,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
