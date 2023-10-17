import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/Auth_models/user_model.dart';
import 'package:http/http.dart' as http;

class IsAdviceRepo {
  Future<LoginModel?> isAdvice() async {
    try {
      http.Response response = await http.get(
          Uri.parse('${Keys.baseUrl}/adviser/setting?key=is_advice'),
          headers: {
            'Accept': 'application/json',
            'lang': Get.locale?.languageCode ?? "ar",
            "Authorization": "Bearer ${sharedPrefs.getToken()}"
          });

      // debugPrint("request is $phone & $pass");
      debugPrint("response is ${response.body.toString()}");
      // debugPrint("response code is ${response.statusCode.toString()}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      // debugPrint("response is ${response.toString()}");

      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = loginModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setIsAdvice(userdata.data!.isAdvice!);
        sharedPrefs.setIsNotification(userdata.data!.isNotification!);
        sharedPrefs.setUserName(userdata.data!.userName!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        // MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        // debugPrint("request is $phone & $pass");
        MyApplication.showToastView(message: responseMap["message"].toString());
      }
    } on TimeoutException catch (e) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e ,st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
