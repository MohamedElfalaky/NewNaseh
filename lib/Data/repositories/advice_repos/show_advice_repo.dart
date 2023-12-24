import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import 'package:http/http.dart' as http;
import '../../models/advice_models/show_advice_model.dart';


class ShowAdviceRepo {
  Future<ShowAdviceModel?> show(int id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/adviser/advice/show/$id'),
        headers: {
          'Accept': 'application/json',
          'lang': Get.locale?.languageCode??"ar",
          "Authorization": "Bearer ${sharedPrefs.getToken()}"
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final homeStatusData = showAdviceModelFromJson(responseMap);
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
