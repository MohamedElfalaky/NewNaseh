import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/Auth_models/register_model.dart';
import 'package:http/http.dart' as http;

class Register {
  Future<RegisterModel?> register({
    String? phone,
    String? pass,
    String? fullName,
    String? mobile,
    String? countryId,
    String? cityId,
    String? gender,
    String? nationalityId,
    String? category,
    String? userName,
    String? info,
    String? avatar,
    String? description,
    String? experienceYear,
    String? documents,
    String? bankName,
    String? bankAccount,
    String? birthday,
  }) async {
    try {
      var response = await http.post(
          Uri.parse('${Keys.baseUrl}/adviser/auth/store'),
          headers: GlobalVars().headers,
          body: {
            'email': '$phone',
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
            'avatar': '$avatar',
            'description': '$description',
            'experience_year': '$experienceYear',
            'document[]': '$documents',
            'bank_name': '$bankName',
            'bank_account': '$bankAccount',
            'birthday': '$birthday',
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = registerModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setUserName(userdata.data!.userName!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
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
