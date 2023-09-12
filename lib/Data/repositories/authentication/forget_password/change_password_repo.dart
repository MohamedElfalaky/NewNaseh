import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/myApplication.dart';
import '../../../models/Auth_models/user_model.dart';

class ChangePassRepo {
  Future<LoginModel?> change(
      {String? phone, String? pass, String? passwordConfirmation}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/forget_password/change_password'),
          headers: GlobalVars().headers,
          body: {
            'mobile': '$phone',
            'password': '$pass',
            'password_confirmation': passwordConfirmation,
          });
      // debugPrint("request is $phone & $pass");
      debugPrint("response is ${response.body.toString()}");
      // debugPrint("response code is ${response.statusCode.toString()}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      // debugPrint("response is ${response.toString()}");

      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = loginModelFromJson(responseMap);

        // MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        // debugPrint("request is $phone & $pass");
        MyApplication.showToastView(message: responseMap["message"]);
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
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
