import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationController.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/components/certificateItem.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage5/RegistrationStage5.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';

class RegistrationStage4 extends StatefulWidget {
  const RegistrationStage4({Key? key}) : super(key: key);

  @override
  State<RegistrationStage4> createState() => _RegistrationStage4State();
}

List<Map<String, dynamic>> certiList = [];

class _RegistrationStage4State extends State<RegistrationStage4> {
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
                child: MyButton(
                  isBold: true,
                  txt: "التالي",
                  onPressedHandler: () {
                    MyApplication.navigateTo(context, RegistrationStage5());
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  "خطوة 4 من 7",
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
            title: const Text("معلومات التخصص"),
            leading: const myBackButton()),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RegistrationController.r4Body(context),
        ),
      ),
    );
  }

/////////////// returns
  // Container certificates({required String cert}) {
  //   return Container(
  //     margin: const EdgeInsetsDirectional.only(end: 4, bottom: 4),
  //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
  //     decoration: BoxDecoration(
  //         color: const Color(0XFFEEEEEE),
  //         borderRadius: BorderRadius.circular(10)),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           cert,
  //           style: TextStyle(fontFamily: Constants.mainFont, fontSize: 10),
  //         ),
  //         const SizedBox(
  //           width: 8,
  //         ),
  //         Container(
  //           height: 14,
  //           width: 14,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(100),
  //               border: Border.all(color: const Color(0XFF5C5E6B))),
  //           child: const Center(
  //             child: Icon(
  //               Icons.close_outlined,
  //               size: 12,
  //               color: Color(0XFF5C5E6B),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
