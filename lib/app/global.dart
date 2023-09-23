import 'package:get/get.dart';

/// vars with changeable values
class GlobalVars {
  Map<String, String>? headers = {
    'Accept': 'application/json',
    'lang': Get.locale?.languageCode??"ar",
    // 'Content-Type': 'application/json',
  };
  String? oldLang;

  String? androidRelease;
}

