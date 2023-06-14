import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/Data/models/Auth_models/category_model.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;

import '../../../../app/utils/myApplication.dart';

class CategoryRepo {
  Future<CategoryModel?> getData() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/adviser/coredata/category/list'),
        // headers: GlobalVars().headers,
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(responseMap.toString());
        final categoryFields = categoryModelFromJson(responseMap);
        print("Data from Api is ${categoryFields.data![0].id}");

        // MyApplication.showToastView(message: responseMap["message"]);
        return categoryFields;
      } else {
        // debugPrint("request is $phone & $pass");
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