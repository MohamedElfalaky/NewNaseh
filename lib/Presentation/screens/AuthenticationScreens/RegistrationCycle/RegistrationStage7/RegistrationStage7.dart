import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationController.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/MyButtonOutlined.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/utils/registeration_values.dart';
import '../../../../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../../../../Data/cubit/authentication/country_cubit/country_state.dart';
import '../../../../../Data/cubit/authentication/nationality_cubit/nationality_cubit.dart';
import '../../../../../Data/cubit/authentication/register_cubit/register_cubit.dart';
import '../../../../../Data/cubit/authentication/register_cubit/register_state.dart';
import '../../../../../Data/models/Auth_models/country_model.dart';
import '../../../../../Data/models/Auth_models/nationality_model.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';

class RegistrationStage7 extends StatefulWidget {
  const RegistrationStage7({Key? key}) : super(key: key);

  @override
  State<RegistrationStage7> createState() => _RegistrationStage7State();
}

class _RegistrationStage7State extends State<RegistrationStage7> {
  @override
  void initState() {
    context.read<CountryCubit>().getCountries();
    context.read<NationalityCubit>().getNationalities();
    super.initState();
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
            centerTitle: false,
            leadingWidth: 70,
            title: const Text("معلومات إضافية"),
            leading: const MyBackButton(),
          ),
          body:
              // BlocBuilder<CountryCubit, CountryState>(
              //     builder: (context, state) {
              //   if (state is CountryLoading) {
              //     return const Center(child: CircularProgressIndicator());
              //   } else if (state is CountryLoaded) {
              // countryResponse = state.response;
              // return

    BlocBuilder<RegisterCubit, RegisterState>(
    builder: (context, state) =>

              Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                Expanded(child: RegistrationController.r7Body()),
                Padding(
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
                            state is RegisterLoading
                                ? const Center(child: CircularProgressIndicator())
                                :     Flexible(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8.0),
                                child: MyButton(
                                  isBold: true,
                                  txt: "إتمام التسجيل",
                                  onPressedHandler: () {

                                    context.read<RegisterCubit>().registerMethod(
                                        context: context,
                                        userName: "Data",
                                        nationalityId: "1",
                                        mobile: "010121",
                                        info:"Ahemd",
                                        gender: "0",
                                        fullName: "ahmed",
                                        experienceYear: "55",
                                        avatar: inputImagePhoto,
                                        bankAccount: "23025",
                                        bankName: "Ahmed",
                                        birthday: "24/12",
                                        category: "1",
                                        cityId: "1",
                                        countryId: "1",
                                        description:"agcsadddddddddddddddddx" ,
                                        documents:"scdddddddd" ,
                                        );
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: MyButtonOutlined(
                                isBold: false,
                                txt: "تخطي",
                                onPressedHandler: () {},
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
                          "خطوة 7 من 7",
                          style: Constants.subtitleRegularFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          // } else if (state is CountryError) {
          //   return const Center(child: Text('error'));
          // } else {
          //   return const Center(child: Text('....'));
          // }
          // })
          ),
    ));
  }
}
