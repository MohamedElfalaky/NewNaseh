import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/Data/cubit/authentication/nationality_cubit/nationality_cubit.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationController.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:nasooh/app/utils/registeration_values.dart';
import '../../../Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import '../../../Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../../Data/cubit/authentication/category_cubit/category_state.dart';
import '../../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../../Data/cubit/profile/profile_cubit/profile_cubit.dart';
import '../../../Data/cubit/profile/profile_cubit/profile_state.dart';
import '../../../Data/cubit/profile/update_profile_cubit/update_profile_cubit.dart';
import '../../../Data/cubit/profile/update_profile_cubit/update_profile_state.dart';
import '../../../Data/models/Auth_models/category_model.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../../app/utils/validations.dart';
import '../../widgets/my_drop_down_list.dart';
import '../../widgets/row_modal_sheet.dart';
import '../AuthenticationScreens/RegistrationCycle/RegistrationStage4/components/certificateItem.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final ImagePicker _picker = ImagePicker();
  XFile? regImage;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _englishName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController certificatesController = TextEditingController();
  bool _termsConditions = false;
  String? genderValue;
  String? base64NewImage;
  List<CategoryData> categoryData = [];
  final TextEditingController _searchController = TextEditingController();
  List<CategoryData> results = [];

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final myImage = await _picker.pickImage(source: source, imageQuality: 60);
      if (myImage == null) return;

      setState(() {
        regImage = myImage;
      });
      List<int> imageBytes = await File(regImage!.path).readAsBytesSync();
      print("regImage is $regImage");
      base64NewImage = base64.encode(imageBytes);
      print("inputImagePhoto!.path  is ${regImage!.path}");
      // log("base64Image!  is ${base64NewImage}");
    } on PlatformException catch (e) {
      print("platform exeption : $e");
    }
    Navigator.pop(context);
  }

  List<Map<String, dynamic>> certiList = [];
  List<int> _selectedCategory = [];

  Future<void> getDataFromApi() async {
    await context.read<ProfileCubit>().getDataProfile();
    await context.read<CountryCubit>().getCountries();
    await context.read<NationalityCubit>().getNationalities();

    var profileCubit = ProfileCubit.get(context);
    _fullName.text = profileCubit.profileModel?.data?.fullName ?? "";
    _email.text = profileCubit.profileModel?.data?.email ?? "";
    _englishName.text = profileCubit.profileModel?.data!.userName ?? "";
    _descriptionController.text =
        profileCubit.profileModel?.data?.description ?? "";
    _summaryController.text = profileCubit.profileModel?.data?.info ?? "";
    _experienceController.text =
        profileCubit.profileModel?.data?.experienceYear ?? "";
    _selectedCategory =
        profileCubit.profileModel!.data!.category!.map((e) => e.id!).toList();
    print(_selectedCategory);
    print("_selectedCategory");

    // _password.text = profileState.response!.data!.!;
    // _phoneController.text =
    //     profileState.response!.data!.mobile!.substring(5, 14);
    if (profileCubit.profileModel?.data?.gender != "") {
      genderValue = profileCubit.profileModel?.data?.gender ?? "";
    }
    // if (profileCubit.profileModel?.data?.nationalityId != null) {
    //   nationalityValue =
    //       profileCubit.profileModel?.data?.nationalityId?.id.toString();
    // }
    // if (profileCubit.profileModel?.data?.countryId != null) {
    //   countryValue = profileCubit.profileModel?.data?.countryId?.id.toString();
    // context.read<CityCubit>().getCities(
    //     profileState.response!.data!.countryId!.id.toString());
    // }
    // if (profileCubit.profileModel?.data?.cityId != null) {
    //   cityValue = profileCubit.profileModel?.data?.cityId!.id.toString();
    // }
  }

  @override
  void initState() {
    getDataFromApi();
    context.read<CategoryCubit>().getCategories();

    print("the image from api is ${sharedPrefs.getUserPhoto()}");
    super.initState();

///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(message: "noInternet".tr);
      }
    });

    // todo subscribe to internet change
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: "noInternet".tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                builder: (context, state) => state is UpdateProfileLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: MyButton(
                            isBold: true,
                            txt: "save".tr,
                            onPressedHandler: () {
                              print(inputCity);
                              print(inputCountry);
                              print("base64NewImage is ${base64NewImage}");
                              print(inputCountry);
                              print(
                                  "selectedCategory is ${_selectedCategory.toSet().toList().toString().split("[").last.split("]").first}");

                              var documents =
                                  certiList.map((e) => e["cert"]).toList();
                              print(
                                  "selectedCategory is ${documents.toString().split("[").last.split("]").first}");
                              print(documents.toString());
                              context.read<UpdateProfileCubit>().updateMethod(
                                    context: context,
                                    nationalityId: inputNationality,
                                    gender: genderValue,
                                    fullName: _fullName.text,
                                    email: _email.text,
                                    cityId: inputCity,
                                    category:
                                    // "635,637",
                                    _selectedCategory
                                        .toSet()
                                        .toList()
                                        .toString()
                                        .split("[")
                                        .last
                                        .split("]")
                                        .first,
                                    documents: documents
                                        .toString()
                                        .split("[")
                                        .last
                                        .split("]")
                                        .first,
                                    description: _descriptionController.text,
                                    birthday: _birthdayController.text,
                                    bankName: _bankNameController.text,
                                    bankAccount: _bankAccountController.text,
                                    experienceYear: _experienceController.text,
                                    info: _summaryController.text,
                                    userName: _englishName.text,
                                    countryId: inputCountry,
                                    avatar: base64NewImage??"" ,
                                    // mobile: "0101258631255",
                                  );
                            },
                          ),
                        ),
                      )),
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.whiteAppColor,
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 70,
          title: Row(
            children: [
              Text("Edit Profile".tr),
            ],
          ),
          leading: MyBackButton(),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (profileState is ProfileLoaded) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          title: Text(
                            "personal information".tr,
                            style: Constants.mainTitleFont,
                          ),
                          children: [
                            // RegistrationController.r3Body(context, setState)
                            Column(
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
                                                      // color: const Color(
                                                      //     0XFFF8F8F9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: regImage == null &&
                                                          sharedPrefs
                                                                  .getUserPhoto() ==
                                                              ""
                                                      ? Image.network(
                                                          "https://th.bing.com/th/id/R.daced5c5d9871280ca8e2de03bf8bee5?rik=sUyBpUyNvR6IqQ&pid=ImgRaw&r=0")
                                                      : regImage == null &&
                                                              sharedPrefs
                                                                      .getUserPhoto() !=
                                                                  ""
                                                          ? Image.network(
                                                              sharedPrefs
                                                                  .getUserPhoto())
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              child: Image.file(
                                                                File(regImage!
                                                                    .path),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              // PhotoView(
                                                              //     imageProvider:
                                                              //         FileImage(
                                                              //   File(
                                                              //       regImage!.path),
                                                              // )),
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  // <-- SEE HERE
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(25.0),
                                                  ),
                                                ),
                                                builder: (ctx) {
                                                  return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18),
                                                      // height: 100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          RowModalSheet(
                                                              txt: "camera".tr,
                                                              imageIcon:
                                                                  cameraIcon,
                                                              onPressed: () {
                                                                pickImage(
                                                                    ImageSource
                                                                        .camera,
                                                                    ctx);
                                                              }),
                                                          Divider(),
                                                          RowModalSheet(
                                                            txt: "gellery".tr,
                                                            imageIcon:
                                                                galleryIcon,
                                                            onPressed: () {
                                                              pickImage(
                                                                  ImageSource
                                                                      .gallery,
                                                                  ctx);
                                                            },
                                                          ),
                                                          Divider(),
                                                          RowModalSheet(
                                                            txt: "cancel".tr,
                                                            imageIcon:
                                                                closeIcon,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ));
                                                },
                                              );
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  Color(0XFF444444),
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
                                                  regImage = null;
                                                  // inputImageName = "";
                                                });
                                              },
                                              child: const CircleAvatar(
                                                  child: Icon(Icons.close))),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 34, bottom: 24),
                                  child: TextFormField(
                                    controller: _fullName,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "full Name Required".tr;
                                      } else if (value.length > 33 ||
                                          value.length < 2) {
                                        return "name length".tr;
                                      }
                                      return null;
                                    },
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText:
                                                "الاسم ثلاثي باللغة العربية ..سيظهر للمستخدمين",
                                            prefixIcon: SvgPicture.asset(
                                              nameIcon,
                                              height: 24,
                                            )),
                                  ),
                                ),
                                TextFormField(
                                  controller: _englishName,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "User Name Required".tr;
                                    }
                                    if (value.length > 17 || value.length < 5) {
                                      return "User Name Length".tr;
                                    }
                                    // else if   (!validEnglish(value)) {
                                    //   return 'الاسم يجب ان يحتوي علي حروف انجليزية و أرقام' ;
                                    // }
                                    return null;
                                  },
                                  decoration: Constants
                                      .setRegistrationTextInputDecoration(
                                          hintText:
                                              "اسم المستخدم باللغة الإنجليزية...",
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
                                    controller: _email,
                                    validator: (val) {
                                      if (val!.isEmpty ||
                                          !RegExp(Validations.validationEmail)
                                              .hasMatch(val)) {
                                        return "Email data".tr;
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText: "Email ...".tr,
                                            prefixIcon: SvgPicture.asset(
                                              mailLink,
                                              height: 24,
                                            )),
                                  ),
                                ),
                                // TextFormField(
                                //   controller: _password,
                                //   validator: (val) {
                                //     if (val!.isEmpty || val.length < 8) {
                                //       return getTranslated(
                                //           context, "password data".tr;
                                //     }
                                //     return null;
                                //   },
                                //   autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //   decoration: Constants
                                //       .setRegistrationTextInputDecoration(
                                //           hintText: "كلمة المرور...",
                                //           prefixIcon: SvgPicture.asset(
                                //             passField,
                                //             height: 24,
                                //           )),
                                // ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          ]),
                      ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          title: const Text(
                            "معلومات التخصص",
                            style: Constants.mainTitleFont,
                          ),
                          children: [
                            // RegistrationController.r4Body(context)
                            Form(
                              key: stage4FormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: TextFormField(
                                      maxLength: 35,
                                      controller: _descriptionController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "description Required".tr;
                                        } else if (value.length < 3) {
                                          return "short description".tr;
                                        }
                                        return null;
                                      },
                                      decoration: Constants
                                          .setRegistrationTextInputDecoration(
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "summary Required".tr;
                                        }
                                        return null;
                                      },
                                      decoration: Constants
                                          .setRegistrationTextInputDecoration(
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "experience Required".tr;
                                        }
                                        return null;
                                      },
                                      decoration: Constants
                                          .setRegistrationTextInputDecoration(
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
                                      decoration: Constants
                                          .setRegistrationTextInputDecoration(
                                              hintText:
                                                  "الشهادات والإنجازات...",
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (certificatesController
                                                        .text.isNotEmpty) {
                                                      var idd = DateTime.now()
                                                          .toString();
                                                      certiList.add({
                                                        "widget": certificateItem(
                                                            cert:
                                                                certificatesController
                                                                    .text,
                                                            staticId: idd),
                                                        "cert":
                                                            certificatesController
                                                                .text,
                                                        "id": idd
                                                      });
                                                      certificatesController
                                                          .clear();
                                                      MyApplication
                                                          .dismissKeyboard(
                                                              context);
                                                      BlocProvider.of<
                                                                  AddCertificateCubit>(
                                                              context)
                                                          .addCertificate();
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 8),
                                                    child: SvgPicture.asset(
                                                      certIcaddCertIconon,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              prefixIcon: SvgPicture.asset(
                                                certIcon,
                                                height: 24,
                                              )),
                                    ),
                                  ),
                                  BlocBuilder<AddCertificateCubit,
                                      AddCertificateState>(
                                    builder: (context, state) {
                                      return Wrap(
                                        children: certiList
                                            .map((e) => e["widget"] as Widget)
                                            .toList(),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            )
                          ]),

                      ExpansionTile(
                        tilePadding: const EdgeInsets.all(0),
                        title: const Text(
                          "مجالات التخصص",
                          style: Constants.mainTitleFont,
                        ),
                        children: [
                          BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is CategoryLoaded) {
                              return _buildCard(context, state.response!);
                            } else if (state is CategoryError) {
                              return const Center(child: Text('error'));
                            } else {
                              return const Center(child: Text('....'));
                            }
                          })
                        ],
                      ),
                      // ListTile(
                      //     contentPadding: const EdgeInsets.all(0),
                      //     onTap: () => MyApplication.navigateTo(
                      //         context, const RegistrationStage5()),
                      //
                      //     trailing: const Icon(
                      //       Icons.keyboard_arrow_left_outlined,
                      //       size: 26,
                      //     )
                      //     // children: [
                      //
                      //     // ]
                      //     ),
                      ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          title: Text(
                            "additional information".tr,
                            style: Constants.mainTitleFont,
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: TextFormField(
                                    controller: _bankNameController,
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText:
                                                "اسم صاحب الحساب البنكي...",
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText:
                                                "آيبانIBAN Number...  SA***********",
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
                                            activeColor:
                                                Constants.primaryAppColor,
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText: "تاريخ الميلاد...",
                                            prefixIcon: SvgPicture.asset(
                                              dateIcon,
                                              height: 24,
                                            )),
                                  ),
                                ),
                                Text(
                                  "gender".tr,
                                  style: Constants.secondaryTitleFont,
                                ),
                                StatefulBuilder(
                                  builder: (context, StateSetter setState) =>
                                      Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: RadioListTile(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Text(
                                              "male".tr,
                                              style: Constants
                                                  .secondaryTitleRegularFont,
                                            ),
                                            value: "1",
                                            groupValue: genderValue,
                                            onChanged: (s) {
                                              setState(() {
                                                genderValue = s;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: RadioListTile(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Text(
                                              "female".tr,
                                              style: Constants
                                                  .secondaryTitleRegularFont,
                                            ),
                                            value: "0",
                                            groupValue: genderValue,
                                            onChanged: (s) {
                                              setState(() {
                                                genderValue = s;
                                              });
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 90,
                                )
                              ],
                            )
                            // RegistrationController.r6Body(setState)
                          ]),
                      ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          title: const Text(
                            "بيانات الموقع وحسابات التواصل",
                            style: Constants.mainTitleFont,
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
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
                                    decoration: Constants
                                        .setRegistrationTextInputDecoration(
                                            hintText: "ادخل رابط يوتيوب...",
                                            prefixIcon: SvgPicture.asset(
                                              youtubeIcon,
                                              height: 24,
                                            )),
                                  ),
                                ),
                              ],
                            )
                            // RegistrationController.r7Body()
                          ]),
                      const SizedBox(
                        height: 90,
                      )
                    ],
                  )),
            );
          } else if (profileState is ProfileError) {
            return const Center(child: SizedBox());
          } else {
            return const Center(child: SizedBox());
          }
        }),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CategoryModel model) {
    return Container(
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
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      categoryData = model.data!;
                      List<CategoryData> searchList(String query) {
                        return categoryData
                            .where((item) => item.name!.contains(query))
                            .toList();
                      }

                      results = searchList(_searchController.text);
                      print(results.length);
                    });
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "ابحث عن المجالات التي تجيديها...",
                      prefixIcon: SvgPicture.asset(
                        searchIcon,
                        height: 24,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _searchController.text.isEmpty
                    ? ListView.builder(
                        itemCount: model.data!.length,
                        itemBuilder: (context, int x) {
                          // List<MyNewModel> newList = model.data!.map((obj) {
                          //   return MyNewModel(id: obj.id!, booleanValue: false);
                          // }).toList();
                          // MyNewModel item = newList[x];

                          return ExpansionTile(
                              tilePadding: const EdgeInsets.all(0),
                              // leading: SizedBox(
                              //     height: 24,
                              //     width: 24,
                              //     child: Checkbox(value: false, onChanged: (s) {})),
                              title: Row(
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                          value: model.data![x].selected,
                                          onChanged: (bool? s) {
                                            setState(() {
                                              model.data![x].selected = s;
                                              if (model.data![x].selected ==
                                                  true) {
                                                _selectedCategory
                                                    .add(model.data![x].id!);

                                                for (var selectItems in model
                                                    .data![x].children!) {
                                                  selectItems.selected = true;
                                                  _selectedCategory
                                                      .add(selectItems.id!);
                                                }
                                              } else if (model
                                                      .data![x].selected ==
                                                  false) {
                                                _selectedCategory.removeWhere(
                                                    (e) =>
                                                        e == model.data![x].id);
                                              }
                                            });
                                            debugPrint(
                                                "the send category is ${_selectedCategory.toSet().toList().toString()}");
                                          })),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.data![x].name!,
                                      style: Constants.secondaryTitleFont,
                                    ),
                                  ),
                                ],
                              ),
                              children: model.data![x].children!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12, end: 4, top: 4, bottom: 4),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: Checkbox(
                                                  value: e.selected,
                                                  onChanged: (s) {
                                                    setState(() {
                                                      e.selected = s;
                                                      if (e.selected == true) {
                                                        _selectedCategory
                                                            .add(e.id!);
                                                      } else if (e.selected ==
                                                          false) {
                                                        _selectedCategory
                                                            .removeWhere(
                                                                (element) =>
                                                                    element ==
                                                                    e.id);
                                                      }
                                                      debugPrint(
                                                          "the send category is ${_selectedCategory.toSet().toList().toString()}");
                                                    });
                                                  })),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            e.name!,
                                            style: Constants
                                                .secondaryTitleRegularFont,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList());
                        },
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, int x) => ExpansionTile(
                            tilePadding: const EdgeInsets.all(0),
                            title: Row(
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                        value: results[x].selected,
                                        onChanged: (bool? s) {
                                          setState(() {
                                            results[x].selected = s;
                                            if (results[x].selected == true) {
                                              _selectedCategory
                                                  .add(results[x].id!);

                                              for (var selectItems
                                                  in results[x].children!) {
                                                selectItems.selected = true;
                                                _selectedCategory
                                                    .add(selectItems.id!);
                                              }
                                            } else if (results[x].selected ==
                                                false) {
                                              _selectedCategory.removeWhere(
                                                  (e) => e == results[x].id);
                                            }
                                          });
                                          debugPrint(
                                              "the send category is ${_selectedCategory.toSet().toList().toString()}");
                                        })),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    results[x].name!,
                                    style: Constants.secondaryTitleFont,
                                  ),
                                ),
                              ],
                            ),
                            children: results[x]
                                .children!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12, end: 4, top: 4, bottom: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Checkbox(
                                                value: e.selected,
                                                onChanged: (s) {
                                                  setState(() {
                                                    e.selected = s;
                                                    if (e.selected == true) {
                                                      _selectedCategory
                                                          .add(e.id!);
                                                    } else if (e.selected ==
                                                        false) {
                                                      _selectedCategory
                                                          .removeWhere(
                                                              (element) =>
                                                                  element ==
                                                                  e.id);
                                                    }
                                                    debugPrint(
                                                        "the send category is ${_selectedCategory.toSet().toList().toString()}");
                                                  });
                                                })),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          e.name!,
                                          style: Constants
                                              .secondaryTitleRegularFont,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          )),
    );
  }
}
