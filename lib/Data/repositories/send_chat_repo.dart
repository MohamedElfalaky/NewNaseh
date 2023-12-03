import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import 'package:http/http.dart' as http;

class SendChatRepo {
  Future<bool?> sendChat({
    String? msg,
    String? adviceId,
    String? file,
    String? type,
  }) async {
    try {
      Map<String, dynamic> map = {
        'message': msg,
        'advice_id': '$adviceId',
        if (file != null) 'document[0][type]': type,
        if (file != null) 'document[0][file]': file,
      };

      http.Response response =
          await http.post(Uri.parse('${Keys.baseUrl}/adviser/chat/store'),
              headers: {
                'Accept': 'application/json',
                'lang': Get.locale?.languageCode ?? "ar",
                "Authorization": "Bearer ${sharedPrefs.getToken()}"
              },
              body: map);
      print("map sending is $map");
      Map<String, dynamic> responseMap = json.decode(response.body);
      print("the sended file is $file");
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        // MyApplication.showToastView(message: responseMap["message"]);
        return true;
      } else {
        MyApplication.showToastView(
            message: responseMap["message"].values.toString());
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