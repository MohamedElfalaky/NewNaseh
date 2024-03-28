import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationController.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage7/RegistrationStage7.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/MyButtonOutlined.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/utils/registeration_values.dart';

import '../../../../../Data/cubit/authentication/register_cubit/register_cubit.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';

class RegistrationStage6 extends StatefulWidget {
  const RegistrationStage6({Key? key}) : super(key: key);

  @override
  State<RegistrationStage6> createState() => _RegistrationStage6State();
}

class _RegistrationStage6State extends State<RegistrationStage6> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: MyButton(
                          isBold: true,
                          txt: "التالي",
                          onPressedHandler: () {
                            MyApplication.navigateTo(
                                context, const RegistrationStage7());
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: MyButtonOutlined(
                        isBold: false,
                        txt: "تخطي",
                        onPressedHandler: () {
                          context.read<RegisterCubit>().registerMethod(
                                pass: inputPassword,
                                email: inputEmail,
                                context: context,
                                userName: inputEnglishName,
                                nationalityId: inputNationality,
                                mobile: inputPhone,
                                info: inputSummary,
                                gender: inputGender,
                                fullName: inputFullName,
                                experienceYear: inputExperience,
                                avatar: base64Image ?? "",
                                bankAccount: inputBankAccount,
                                bankName: inputBankName,
                                birthday: inputBirthday,
                                category:
                                    // "19",
                                    sendCategory
                                        .toSet()
                                        .toList()
                                        .toString()
                                        .split("[")
                                        .last
                                        .split("]")
                                        .first,
                                cityId: inputCity,
                                countryId: inputCountry,
                                description: inputDescription,
                                documents: inputDocuments
                                    .toString()
                                    .split("[")
                                    .last
                                    .split("]")
                                    .first,
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  "خطوة 6 من 7",
                  style: Constants.subtitleRegularFont,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 70,
          title: const Text("معلومات إضافية"),
          leading: MyBackButton(),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: RegistrationController.r6Body(setState, context)),
      ),
    );
  }

/////////////// returns
}
