import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;

import '../../../../app/utils/myApplication.dart';
import '../../../models/Auth_models/nationality_model.dart';

class NationalityRepo {
  Future<NationalityModel?> getNationalities() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/adviser/coredata/nationality/list'),
        // headers: GlobalVars().headers,
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(responseMap.toString());
        final categoryFields = nationalityModelFromJson(responseMap);
        print("Data from Api is ${categoryFields.data![0].id}");

        // MyApplication.showToastView(message: responseMap["message"]);
        return categoryFields;
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
  }
}