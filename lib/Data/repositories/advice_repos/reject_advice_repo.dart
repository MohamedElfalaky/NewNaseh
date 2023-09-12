import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import 'package:http/http.dart' as http;
import '../../models/advice_models/show_advice_model.dart';

class RejectAdviceRepo {
  Future<ShowAdviceModel?> reject(
      {int? id, String? reject, String? rejectOther}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/advice/reject/$id'),
          headers: {
            'Accept': 'application/json',
            // 'lang': selectedLang!,
            'lang': "ar",
            "Authorization": "Bearer ${sharedPrefs.getToken()}"
          },
          body: {
            "reject": reject,
            "reject_other": rejectOther
          });
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