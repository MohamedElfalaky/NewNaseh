import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nasooh/Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/RegistrationStage4.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/components/certificateItem.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:convert';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/registeration_values.dart';
import '../../../../app/utils/validations.dart';
import '../../../widgets/my_drop_down_list.dart';
import '../../../widgets/row_modal_sheet.dart';

final stage3FormKey = GlobalKey<FormState>();
final stage4FormKey = GlobalKey<FormState>();
RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
//A function that validate user entered password
bool validatePassword(String pass) {
  String _password = pass.trim();
  if (pass_valid.hasMatch(_password)) {
    return true;
  } else {
    return false;
  }
}

bool validEnglish(String value) {
  RegExp regex = RegExp(r'/^[A-Za-z0-9]*$');
  return (!regex.hasMatch(value)) ? false : true;
}

class RegistrationController {
  /// r3
  static final ImagePicker _picker = ImagePicker();
  static XFile? regImage;
  static final TextEditingController _fullName = TextEditingController();
  static final TextEditingController _englishName = TextEditingController();
  static final TextEditingController _email = TextEditingController();
  static final TextEditingController _password = TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();
  static final TextEditingController _summaryController =
      TextEditingController();
  static final TextEditingController _experienceController =
      TextEditingController();
  static final TextEditingController _bankNameController =
      TextEditingController();
  static final TextEditingController _bankAccountController =
      TextEditingController();
  static final TextEditingController _birthdayController =
      TextEditingController();

  static Future pickImage(
      ImageSource source, BuildContext context, setState) async {
    try {
      final myImage = await _picker.pickImage(source: source, imageQuality: 60);
      if (myImage == null) return;

      setState(() {
        regImage = myImage;
        inputImagePhoto = regImage;
      });
      List<int> imageBytes = await File(regImage!.path).readAsBytesSync();
      print(imageBytes);
      base64Image = base64.encode(imageBytes);
      print("inputImagePhoto!.path  is ${inputImagePhoto!.path}");
      log("base64Image!  is ${base64Image}");
    } on PlatformException catch (e) {
      print("platform exeption : $e");
    }
    Navigator.pop(context);
  }

  static Widget r3Body(context, setState) {
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: stage3FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 190,
                  width: 190,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: DottedBorder(
                          color: Constants.outLineColor,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          dashPattern: const [10, 6],
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                                height: 160,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: const Color(0XFFF8F8F9),
                                    borderRadius: BorderRadius.circular(16)),
                                child: RegistrationController.regImage == null
                                    ? SvgPicture.asset(
                                        logotrans,
                                        color:
                                            Colors.transparent.withOpacity(.2),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: PhotoView(
                                            imageProvider: FileImage(
                                          File(RegistrationController
                                              .regImage!.path),
                                        )
                                            // Image.file(
                                            //   File(regImage!.path),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            ),
                                      )),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                // <-- SEE HERE
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              builder: (ctx) {
                                return Container(
                                    padding: const EdgeInsets.all(18),
                                    // height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RowModalSheet(
                                            txt: "كاميرا",
                                            imageIcon: cameraIcon,
                                            onPressed: () {
                                              RegistrationController.pickImage(
                                                  ImageSource.camera,
                                                  ctx,
                                                  setState);
                                              // inputImageName =
                                              //     RegistrationController
                                              //         .regImage!.path;
                                              // inputImagePhoto =
                                              //     RegistrationController
                                              //         .regImage;
                                              // print(
                                              //     "Image PAth is $inputImageName");
                                            }),
                                        Divider(),
                                        RowModalSheet(
                                          txt: "الاستديو",
                                          imageIcon: galleryIcon,
                                          onPressed: () {
                                            RegistrationController.pickImage(
                                                ImageSource.gallery,
                                                ctx,
                                                setState);
                                            // inputImageName =
                                            //     RegistrationController
                                            //         .regImage!.path;
                                            // inputImagePhoto =
                                            //     RegistrationController
                                            //         .regImage;
                                            // print(
                                            //     "Image path is ${inputImagePhoto!.path}");
                                          },
                                        ),
                                        Divider(),
                                        RowModalSheet(
                                          txt: "الغاء",
                                          imageIcon: closeIcon,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ));
                              },
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color(0XFF444444),
                            radius: 20,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                inputImagePhoto =
                                    RegistrationController.regImage = null;
                                // inputImageName = "";
                              });
                            },
                            child:
                                const CircleAvatar(child: Icon(Icons.close))),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 34, bottom: 24),
                child: TextFormField(
                  controller: _fullName,
                  onChanged: (val) {
                    inputFullName = _fullName.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, "full Name Required")!;
                    } else if (value.length > 33 || value.length < 2) {
                      return getTranslated(context, "name length")!;
                    }
                    return null;
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "الاسم ثلاثي باللغة العربية ..سيظهر للمستخدمين",
                      prefixIcon: SvgPicture.asset(
                        nameIcon,
                        height: 24,
                      )),
                ),
              ),
              TextFormField(
                controller: _englishName,
                onChanged: (val) {
                  inputEnglishName = _englishName.text;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, "User Name Required")!;
                  }
                  if (value.length > 17 || value.length < 5) {
                    return getTranslated(context, "User Name Length")!;
                  }
                  // else if   (!validEnglish(value)) {
                  //   return 'الاسم يجب ان يحتوي علي حروف انجليزية و أرقام' ;
                  // }
                  return null;
                },
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))
                // ],
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "اسم المستخدم باللغة الإنجليزية...",
                    prefixIcon: SvgPicture.asset(
                      linkIcon,
                      height: 24,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "سيستخدم في رابط صفحتك الشخصية: nasooh.app/ahmed",
                  style: TextStyle(
                      fontFamily: Constants.mainFont,
                      color: Color(0XFF1ABC9C),
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  onChanged: (val) {
                    inputEmail = _email.text;
                  },
                  validator: (val) {
                    if (val!.isEmpty ||
                        !RegExp(Validations.validationEmail).hasMatch(val)) {
                      return getTranslated(context, "Email data")!;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "البريد الإلكتروني...",
                      prefixIcon: SvgPicture.asset(
                        mailLink,
                        height: 24,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  controller: _password,
                  onChanged: (val) {
                    inputPassword = _password.text;
                  },
                  validator: (val) {
                    if (val!.isEmpty || val.length < 8
                        // ||
                        // !RegExp(Validations.validationPassword.toString()).hasMatch(val)
                        ) {
                      return getTranslated(context, "password data")!;
                    }
                    bool result = validatePassword(val);
                    if (result) {
                      return null;
                    } else {
                      return " Password should contain Capital, small letter & Number & Special";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "كلمة المرور...",
                      prefixIcon: SvgPicture.asset(
                        passField,
                        height: 24,
                      )),
                ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ));
  }

  /// r4
  static TextEditingController certificatesController = TextEditingController();

  static Widget r4Body(context) {
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: stage4FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  maxLength: 35,
                  controller: _descriptionController,
                  onChanged: (val) {
                    inputDescription = _descriptionController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, "description Required")!;
                    } else if (value.length < 4) {
                      return getTranslated(context, "short description")!;
                    }
                    return null;
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText:
                          "الوصف المختصر | مثال: خبير في البرمجة والتصميم",
                      prefixIcon: SvgPicture.asset(
                        wasfIcon,
                        height: 24,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  maxLength: 770,
                  maxLines: 6,
                  controller: _summaryController,
                  onChanged: (val) {
                    inputSummary = _summaryController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, "summary Required")!;
                    } else if (value.length < 33) {
                      return getTranslated(context, "summary length")!;
                    }
                    return null;
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      isParagraph: true,
                      hintText: "نبذة تعريفية...",
                      prefixIcon: SvgPicture.asset(
                        nabzaIcon,
                        height: 24,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _experienceController,
                  onChanged: (val) {
                    inputExperience = _experienceController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, "experience Required")!;
                    }
                    return null;
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "سنوات الخبرة...",
                      prefixIcon: SvgPicture.asset(
                        khebraIcon,
                        height: 24,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  controller: certificatesController,
                  // maxLength: 10,
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "الشهادات والإنجازات...",
                      suffixIcon: InkWell(
                        onTap: () {
                          if (certificatesController.text.isNotEmpty) {
                            var idd = DateTime.now().toString();
                            certiList.add({
                              "widget": certificateItem(
                                  cert: certificatesController.text,
                                  staticId: idd),
                              "cert": certificatesController.text,
                              "id": idd
                            });
                            certificatesController.clear();
                            MyApplication.dismissKeyboard(context);
                            BlocProvider.of<AddCertificateCubit>(context)
                                .addCertificate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: SvgPicture.asset(
                            certIcaddCertIconon,
                          ),
                        ),
                      ),
                      prefixIcon: SvgPicture.asset(
                        certIcon,
                        height: 24,
                      )),
                ),
              ),
              BlocBuilder<AddCertificateCubit, AddCertificateState>(
                builder: (context, state) {
                  return Wrap(
                    children:
                        certiList.map((e) => e["widget"] as Widget).toList(),
                  );
                },
              ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ));
  }

  /// r6
  static bool _termsConditions = false;

  static Widget r6Body(setState, BuildContext context) {
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                controller: _bankNameController,
                onChanged: (val) {
                  inputBankName = _bankNameController.text;
                },
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "اسم صاحب الحساب البنكي...",
                    prefixIcon: SvgPicture.asset(
                      ipanIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                controller: _bankAccountController,
                onChanged: (val) {
                  inputBankAccount = _bankAccountController.text;
                },
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "آيبانIBAN Number...  SA***********",
                    prefixIcon: SvgPicture.asset(
                      ipanIcon2,
                      height: 24,
                    )),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(ekrar),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "إقرار باالسياسة والعمولة",
                  style: Constants.mainTitleFont,
                ),
                const Spacer(),
                SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        activeColor: Constants.primaryAppColor,
                        value: _termsConditions,
                        onChanged: (d) {
                          setState(() {
                            _termsConditions = d!;
                          });
                        }))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحةما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.",
                style: Constants.subtitleFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _birthdayController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    setState(() {
                      _birthdayController.text = formattedDate;
                    });
                  }
                  // else {
                  //   showModalBottomSheet(context: context, builder: (_)=> Container(
                  //       padding:EdgeInsets.symmetric(vertical: 20 , horizontal: 50),child: Text("Add Date")) );
                  // }
                },
                onChanged: (val) {
                  inputBirthday = _birthdayController.text;
                  print(inputBirthday.toString());
                  print("the birthday is $inputBirthday");
                },
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "تاريخ الميلاد...",
                    prefixIcon: SvgPicture.asset(
                      dateIcon,
                      height: 24,
                    )),
              ),
            ),
            const Text(
              "الجنس",
              style: Constants.secondaryTitleFont,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: RadioListTile(
                      activeColor: Constants.primaryAppColor,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "ذكر",
                        style: Constants.secondaryTitleRegularFont,
                      ),
                      value: 1,
                      groupValue: inputGender,
                      onChanged: (s) {
                        setState(() {
                          inputGender = s;
                        });
                      }),
                ),
                SizedBox(
                  width: 120,
                  child: RadioListTile(
                      activeColor: Constants.primaryAppColor,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "أنثى",
                        style: Constants.secondaryTitleRegularFont,
                      ),
                      value: 0,
                      groupValue: inputGender,
                      onChanged: (s) {
                        setState(() {
                          inputGender = s;
                        });
                      }),
                )
              ],
            ),
            const SizedBox(
              height: 90,
            )
          ],
        ));
  }

  /// r7

  static Widget r7Body() {
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "بيانات الموقع",
                style: Constants.mainTitleFont,
              ),
            ),
            const MyColumnData(),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "حساباتك على وسائل التواصل الاجتماعي",
                style: Constants.mainTitleFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط تويتر...",
                    prefixIcon: SvgPicture.asset(
                      twitterIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط لينكدان...",
                    prefixIcon: SvgPicture.asset(
                      linkedinIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط سناب شات...",
                    prefixIcon: SvgPicture.asset(
                      snapIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط انستقرام...",
                    prefixIcon: SvgPicture.asset(
                      instaIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط فيس بوك...",
                    prefixIcon: SvgPicture.asset(
                      faceBookIcon,
                      height: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextFormField(
                decoration: Constants.setRegistrationTextInputDecoration(
                    hintText: "ادخل رابط يوتيوب...",
                    prefixIcon: SvgPicture.asset(
                      youtubeIcon,
                      height: 24,
                    )),
              ),
            ),
          ],
        ));
  }
}
