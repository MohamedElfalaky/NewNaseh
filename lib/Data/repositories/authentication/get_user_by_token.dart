import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/Auth_models/register_model.dart';

class GetUserRepo {
  Future<RegisterModel?> getUser() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/adviser/auth/get_user'),
        headers: {
          'Accept': 'application/json',
          'lang': Get.locale?.languageCode ?? "ar",
          "Authorization": "Bearer ${sharedPrefs.getToken()}"
        },
      );
      print('${Keys.baseUrl}/adviser/auth/get_user}');
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print("response of get user by token is ${response.body}");
        final userdata = registerModelFromJson(responseMap);
        return userdata;
      } else {
        MyApplication.showToastView(message: responseMap["message"]);
        MyApplication.showToastView(message: "5");
      }
    } on TimeoutException catch (e, st) {
      MyApplication.showToastView(message: e.toString());
      MyApplication.showToastView(message: "9");
      if (kDebugMode) {
        print(e);
        print(st);
      }
    } on SocketException catch (e, st) {
      MyApplication.showToastView(message: e.toString());
      MyApplication.showToastView(message: "10");
      if (kDebugMode) {
        print(e);
        print(st);
      }
    } on Error catch (e, st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
        MyApplication.showToastView(message: "15");
      }
    }
    return null;
  }
}
