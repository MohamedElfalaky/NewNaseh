import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../Data/cubit/authentication/forget_password_cubit/change_password_cubit/change_password_cubit.dart';
import '../../../../Data/cubit/authentication/forget_password_cubit/change_password_cubit/change_password_state.dart';
import '../../../../app/Style/Icons.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/shared.dart';
import '../RegistrationCycle/RegistrationController.dart';
import 'check_mobile_forget_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late AnimationController _animationController;
  late AnimationController _fadeController;
  final focusNode = FocusNode();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animationController.forward();

    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeController.forward();
    super.initState();
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              leadingWidth: 70,
              title: Text(getTranslated(context, "change_password")!),
              leading:  MyBackButton()),
          backgroundColor: Constants.whiteAppColor,
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 64,
                              ),
                              Text(
                                getTranslated(context, "enter_new_password")!,
                                textAlign: TextAlign.end,
                                style: Constants.mainTitleRegularFont
                                    .copyWith(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 64,
                              ),
                              Text(
                                getTranslated(context, "password")!,
                                textAlign: TextAlign.end,
                                style: Constants.mainTitleRegularFont,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FadeTransition(
                                opacity: _fadeController,
                                child: PasswordTextFormField(
                                    controller: _passwordController,
                                    style: Constants.subtitleFont1,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return getTranslated(
                                            context, "password_required");
                                      }
                                      if (value.length < 6) {
                                        return getTranslated(
                                            context, "password_length");
                                      }
                                      bool result = validatePassword(value);
                                      if (result) {
                                        return null;
                                      } else {
                                        return " Password should contain Capital, small letter & Number & Special";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        Constants.setTextInputDecoration(
                                            hintText: "كلمة المرور...",
                                            prefixIcon: Container(
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xFFBDBDBD)))),
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 8),
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8),
                                              child: SvgPicture.asset(
                                                passField,
                                                height: 24,
                                              ),
                                            ))),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                getTranslated(context, 'password_confirm')!,
                                textAlign: TextAlign.end,
                                style: Constants.mainTitleRegularFont,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FadeTransition(
                                opacity: _fadeController,
                                child: PasswordTextFormField(
                                    controller: _confirmPasswordController,
                                    style: Constants.subtitleFont1,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return getTranslated(
                                            context, "password_required");
                                      }
                                      if (value.length < 6) {
                                        return getTranslated(
                                            context, "password_length");
                                      }
                                      if (value != _passwordController.text) {
                                        return getTranslated(
                                            context, "password_not_match");
                                      }
                                      bool result = validatePassword(value);
                                      if (result) {
                                        return null;
                                      } else {
                                        return " Password should contain Capital, small letter & Number & Special";
                                      }
                                    },
                                    decoration:
                                        Constants.setTextInputDecoration(
                                            hintText: "تأكيد كلمة المرور...",
                                            prefixIcon: Container(
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xFFBDBDBD)))),
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 8),
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8),
                                              child: SvgPicture.asset(
                                                passField,
                                                height: 24,
                                              ),
                                            ))),
                              ),
                              const SizedBox(
                                height: 64,
                              ),
                              state is ChangePasswordLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : FadeTransition(
                                      opacity: _fadeController,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: MyButton(
                                          isBold: true,
                                          txt: getTranslated(context, "save")!,
                                          onPressedHandler: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<ChangePasswordCubit>()
                                                  .changePassMethod(
                                                      context: context,
                                                      pass: _passwordController
                                                          .text,
                                                      phone: forgetMob,
                                                      passwordConfirmation:
                                                          _confirmPasswordController
                                                              .text);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                    ),
                    SvgPicture.asset(
                      'assets/images/SVGs/screen layout.svg',
                      width: 100,
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
