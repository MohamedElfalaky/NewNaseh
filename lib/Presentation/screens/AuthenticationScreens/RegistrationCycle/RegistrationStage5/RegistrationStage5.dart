import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage6/RegistrationStage6.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';

class RegistrationStage5 extends StatefulWidget {
  const RegistrationStage5({Key? key}) : super(key: key);

  @override
  State<RegistrationStage5> createState() => _RegistrationStage5State();
}

class _RegistrationStage5State extends State<RegistrationStage5> {
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
                    MyApplication.navigateTo(context, RegistrationStage6());
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  "خطوة 5 من 7",
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
          title: const Text("مجالات التخصص"),
          leading: const myBackButton(),
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 10),
                child: Badge(
                  label: Text("7"),
                  backgroundColor: Color.fromARGB(255, 138, 138, 144),
                  alignment: AlignmentDirectional(0, 25),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Constants.primaryAppColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: SvgPicture.asset(
                      selectedSectors,
                    ),
                  ),
                ),
              ),
            )
          ],
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
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      decoration: Constants.setRegistrationTextInputDecoration(
                          hintText: "ابحث عن المجالات التي تجيديها...",
                          prefixIcon: SvgPicture.asset(
                            searchIcon,
                            height: 24,
                          )),
                    ),
                  ),
                  ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      // leading: SizedBox(
                      //     height: 24,
                      //     width: 24,
                      //     child: Checkbox(value: false, onChanged: (s) {})),
                      title: Row(
                        children: [
                          SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(value: false, onChanged: (s) {})),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "الإلكترونية",
                            style: Constants.secondaryTitleFont,
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 12, end: 4, top: 4, bottom: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                      value: false, onChanged: (s) {})),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "التسويق الألكتروني",
                                style: Constants.secondaryTitleRegularFont,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 12, end: 4, top: 4, bottom: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                      value: false, onChanged: (s) {})),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "التسويق الإعلاني",
                                style: Constants.secondaryTitleRegularFont,
                              ),
                            ],
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 90,
                  )
                ],
              )),
        ),
      ),
    );
  }

/////////////// returns
}
