import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/Data/models/profile_models/profile_model.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/Auth_models/check_mobile_model.dart';
import 'package:http/http.dart' as http;

import '../../models/home_models/home_status_model.dart';

class HomeStatusRepo {
  Future<HomeStatusModel?> getHSList() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/adviser/coredata/status/list'),
        headers: {
          'Accept': 'application/json',
          // 'lang': selectedLang!,
          'lang': "ar",
          "Authorization": "Bearer ${sharedPrefs.getToken()}"
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final homeStatusData = homeStatusModelFromJson(responseMap);
        return homeStatusData;
      } else {
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
