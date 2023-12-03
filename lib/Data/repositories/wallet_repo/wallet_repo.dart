import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app/keys.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/wallet_model/wallet_model.dart';

class WalletRepo {
  Future<WalletData?> getData() async {
    try {
      http.Response response = await http
          .get(Uri.parse('${Keys.baseUrl}/adviser/wallet/show'), headers: {
        'Accept': 'application/json',
        'lang': Get.locale?.languageCode ?? "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // MyApplication.showToastView(message: responseMap["message"]);
        return walletModelFromJson(responseMap).data;
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