import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/rejection_models/post_reject_model.dart';

class PostRejectRepo {
  Future<PostRejectModel?> reject({
    String? commentId,
    String? commentOther,
    String? adviceId,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/advice/reject/$adviceId'),
          headers: {
            'Accept': 'application/json',
            'lang': Get.locale?.languageCode ?? "ar",
            "Authorization": "Bearer ${sharedPrefs.getToken}"
          },
          body: {
            'comment_id': commentId,
            'comment_other': '$commentOther',
          });

      log({
        'comment_id': commentId,
        'comment_other': '$commentOther',
        "adviceId":adviceId
      }.toString() , name: "rejecting Post");
      Map<String, dynamic> responseMap = json.decode(response.body);
      log(response.body ,name: "reject response");
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        log(response.body ,name: "reject response");
        final userdata = postRejectModelFromJson(responseMap);
        // sharedPrefs.setToken(userdata.data!.token!);
        return userdata;
      } else {
        // MyApplication.showToastView(
        //     message: responseMap["message"].values.toString());
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
    } on Error catch (e, st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
