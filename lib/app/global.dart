import 'package:get/get.dart';

 class GlobalVars {
  Map<String, String>? headers = {
    'Accept': 'application/json',
    'lang': Get.locale?.languageCode ?? "ar",
   };
  String? oldLang;

  String? androidRelease;
}
