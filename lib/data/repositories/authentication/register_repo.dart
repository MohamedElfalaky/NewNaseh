import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/Auth_models/register_model.dart';

class Register {
  Future<RegisterModel?> register(
      {String? email,
      String? pass,
      String? fullName,
      String? mobile,
      String? countryId,
      String? cityId,
      dynamic gender,
      String? nationalityId,
      String? category,
      String? userName,
      String? info,
      String? description,
      String? experienceYear,
      String? documents,
      String? bankName,
      String? bankAccount,
      String? birthday,
      String? avatar}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/auth/store'),
          headers: GlobalVars().headers,
          body: {
            'email': email,
            'password': '$pass',
            'full_name': '$fullName',
            'mobile': '$mobile',
            'country_id': '$countryId',
            'city_id': '$cityId',
            'gender': '$gender',
            'nationality_id': '$nationalityId',
            'category': '$category',
            'user_name': '$userName',
            'info': '$info',
            'description': '$description',
            'experience_year': '$experienceYear',
            'bank_name': '$bankName',
            'bank_account': '$bankAccount',
            'birthday': '$birthday',
            'avatar[0][type]': 'png',
            'avatar[0][file]': avatar,
            'document': documents,
            'device': sharedPrefs.fCMToken,
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint(response.body);
        final userdata = registerModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setIsAdvice(userdata.data!.isAdvice!);
        sharedPrefs.setIsNotification(userdata.data!.isNotification!);
        sharedPrefs.setUserName(userdata.data!.userName!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
         MyApplication.showToastView(
             message: responseMap["message"].toString());
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
