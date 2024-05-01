import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nasooh/Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/styles/icons.dart';
import 'package:nasooh/app/utils/my_application.dart';
import 'package:nasooh/main.dart';
import 'package:password_text_field/password_text_field.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../Presentation/screens/terms_and_conditions/terms_conditions_screen.dart';
import '../../../../app/utils/registeration_values.dart';
import '../../../../app/utils/validations.dart';
import '../../../widgets/my_drop_down_list.dart';
import '../../../widgets/row_modal_sheet.dart';
import 'RegistrationStage4/components/certificate_item.dart';
import 'RegistrationStage4/registration_stage4.dart';

final stage3FormKey = GlobalKey<FormState>();
final stage4FormKey = GlobalKey<FormState>();
RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
bool validatePassword(String pass) {
  String password = pass.trim();
  if (passValid.hasMatch(password)) {
    return true;
  } else {
    return false;
  }
}

class RegistrationController {
  /// r3
  static bool termsConditions = false;

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
    final myImage = await _picker.pickImage(source: source, imageQuality: 60);
    if (myImage == null) return;

    setState(() {
      regImage = myImage;
      inputImagePhoto = regImage;
    });
    List<int> imageBytes = File(regImage!.path).readAsBytesSync();
    // print(imageBytes);
    base64Image = base64.encode(imageBytes);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  static Widget register3Body(context, setState) {
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
                                        colorFilter: getFilterColor(
                                            Colors.transparent.withOpacity(.2)),
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
                                        const Divider(),
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
                                        const Divider(),
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
                      if (inputImagePhoto != null)
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
                  maxLength: 33,
                  onTap: unFocusCursorRTL(_fullName),
                  controller: _fullName,
                  onChanged: (val) {
                    inputFullName = _fullName.text;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[\u0600-\u06FF\\s]'))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {

                      return "full Name Required".tr;
                    }
                    if(!value.contains(' '))
                      {
                        return 'يجب إدخال الاسم ثنائي';
                      }

                    else if (value.length > 33 || value.length < 6) {
                      return "name length".tr;
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
                maxLength: 17,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                        '[a-zA-Z1-9\\s]'), // Regular expression for English characters and spaces
                  ),
                ],
                controller: _englishName,
                onTap: () {
                  unFocusCursorRTL(_englishName);
                },
                onChanged: (val) {
                  inputEnglishName = _englishName.text;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "User Name Required".tr;
                  } else if (value.length > 17 || value.length < 4) {
                    return "User Name Length".tr;
                  }

                  return null;
                },
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
                  "سيستخدم في رابط صفحتك الشخصية: nasoh.app/ahmed",
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
                    if (val!.isEmpty) {
                      return "Email data".tr;
                    }
                    if (!RegExp(Validations.validationEmail).hasMatch(val)) {
                      return 'error mail format'.tr;
                    }
                    return null;
                  },
                  onTap: unFocusCursorRTL(_email),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "البريد الإلكتروني...",
                      prefixIcon: SvgPicture.asset(mailLink
                          // height: 24,
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PasswordTextFormField(
                    onTap: unFocusCursorRTL(_password),
                    maxLength: 10,
                    controller: _password,
                    style: Constants.subtitleFont1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) {
                      inputPassword = _password.text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password_required".tr;
                      } else if (value.length < 6 || value.length > 10) {
                        return "password_length".tr;
                      }
                      RegExp regex =
                          RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$');
                      if (!regex.hasMatch(value)) {
                        return 'يجب أن تحتوي كلمة المرور علي رقم وحرف علي الأقل';
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
                                      width: 1, color: Color(0xFFBDBDBD)))),
                          margin: const EdgeInsetsDirectional.only(end: 8),
                          padding: const EdgeInsetsDirectional.all(8),
                          child: SvgPicture.asset(
                            passField,
                            height: 24,
                          ),
                        ))),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ));
  }

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
                  onTap: unFocusCursorRTL(_descriptionController),
                  controller: _descriptionController,
                  onChanged: (val) {
                    inputDescription = _descriptionController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "description Required".tr;
                    } else if (value.length < 4) {
                      return "short description".tr;
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
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\n\n"))
                  ],
                  onTap: unFocusCursorRTL(_summaryController),
                  controller: _summaryController,
                  onChanged: (val) {
                    inputSummary = _summaryController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "summary Required".tr;
                    } else if (value.length < 33) {
                      return "summary length".tr;
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
                  onTap: unFocusCursorRTL(_experienceController),
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  controller: _experienceController,
                  onChanged: (val) {
                    inputExperience = _experienceController.text;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "experience Required".tr;
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
                  onTap: unFocusCursorRTL(certificatesController),
                  controller: certificatesController,
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "الشهادات والإنجازات...",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () {
                            if (certificatesController.text.isNotEmpty) {
                              var idd = DateTime.now().toString();
                              certiList.add({
                                "widget": CertificateItem(
                                    register: true,
                                    cert: certificatesController.text,
                                    staticId: idd),
                                "cert": certificatesController.text,
                                "id": idd
                              });
                              certificatesController.clear();
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
                      ),
                      prefixIcon: SvgPicture.asset(certIcon, height: 24)),
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

  static Widget r6Body(setState, BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: TextFormField(
              onTap: () {
                unFocusCursorRTL(_bankNameController);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 40,
              controller: _bankNameController,
              validator: (val) {
                if (!val!.contains(' ')) {
                  return 'برجاء إدخال الاسم ثنائي';
                }
                return null;
              },
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
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              maxLength: 24,
              onTap: unFocusCursorRTL(_bankAccountController),
              controller: _bankAccountController,
              onChanged: (val) {
                inputBankAccount =
                    _bankAccountController.text.replaceAll(' ', '');
              },
              decoration: Constants.setRegistrationTextInputDecoration(
                  hintText: "آيبانIBAN Number...  SA***********",
                  prefixIcon: SvgPicture.asset(
                    ipanIcon2,
                    height: 24,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 5),
            child: TextFormField(
              controller: _birthdayController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030));

                if (pickedDate != null) {
                  debugPrint(pickedDate.toString());
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  debugPrint(formattedDate);

                  setState(() {
                    _birthdayController.text = formattedDate;
                  });
                }
              },
              onChanged: (val) {
                inputBirthday = _birthdayController.text;
                debugPrint(inputBirthday.toString());
                debugPrint("the birthday is $inputBirthday");
              },
              decoration: Constants.setRegistrationTextInputDecoration(
                  hintText: "تاريخ الميلاد...",
                  prefixIcon: SvgPicture.asset(
                    dateIcon,
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
              InkWell(
                onTap: () {
                  MyApplication.navigateTo(
                      context, const TermsConditionsScreen());
                },
                child: const Text(
                  "إقرار بالسياسة والعمولة",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                      activeColor: Constants.primaryAppColor,
                      value: termsConditions,
                      onChanged: (d) {
                        setState(() {
                          termsConditions = d!;
                        });
                      }))
            ],
          ),
          const SizedBox(height: 10),
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
        ],
      ),
    );
  }

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
            const PersonalData(),
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
