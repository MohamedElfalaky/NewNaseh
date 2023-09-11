import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationController.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/RegistrationStage4.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/lang/language_constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../../app/utils/registeration_values.dart';

class RegistrationStage3 extends StatefulWidget {
  const RegistrationStage3({Key? key}) : super(key: key);

  @override
  State<RegistrationStage3> createState() => _RegistrationStage3State();
}

class _RegistrationStage3State extends State<RegistrationStage3> {
  // static final ImagePicker _picker = ImagePicker();
  // static XFile? regImage;

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final myImage = await _picker.pickImage(source: source);
  //     if (myImage == null) return;

  //     setState(() {
  //       regImage = myImage;
  //     });
  //   } on PlatformException catch (e) {
  //     print("platform exeption : $e");
  //   }
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                  //   if(inputImagePhoto ==null) {
                  //     MyApplication.showToastView(
                  //       message: '${getTranslated(context,"add image please")}');}
                  // else
                    if (stage3FormKey.currentState!.validate()) {
                      debugPrint(inputPhone +
                          // inputImageName +
                          inputFullName +
                          inputEnglishName +
                          inputEmail +
                          inputPassword);
                      MyApplication.navigateTo(context, RegistrationStage4());
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  "خطوة 3 من 7",
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
            title: const Text("المعلومات الشخصية"),
            leading: const MyBackButton()),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: RegistrationController.r3Body(context, setState)),
      ),
    );
  }
}
