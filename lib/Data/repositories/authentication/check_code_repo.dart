import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../models/Auth_models/check_mobile_model.dart';
import 'package:http/http.dart' as http;

class CheckCodeRepo {
  Future<MobModel?> checkCode({String? phone, String? code}) async {
    try {
      var response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/check_mobile/code'),
          headers: GlobalVars().headers,
          body: {
            'mobile': '$phone',
            'code': '$code',
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = mobModelFromJson(responseMap);
        return userdata;
      } else {
        MyApplication.showToastView(message: responseMap["message"]);
      }
    } on TimeoutException catch (e) {
      // todo show toast
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e) {
      // todo show toast
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
  }
}
