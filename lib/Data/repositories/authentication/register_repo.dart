import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../models/Auth_models/register_model.dart';
import 'package:http/http.dart' as http;

class Register {
  Future<RegisterModel?> register(
      {String? phone,
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
      String? description,
      String? experienceYear,
      String? documents,
      String? bankName,
      String? bankAccount,
      String? birthday,
      XFile? avatar}) async {
    var image;
    if (avatar != null) {
      image = await http.MultipartFile.fromPath('image', avatar.path);
    }
    try {
      http.Response response =
          await http.post(Uri.parse('${Keys.baseUrl}/adviser/auth/store'),
              headers: GlobalVars().headers,
              // body: {
              //   'email': '$phone',
              //   'password': '$pass',
              //   'full_name': '$fullName',
              //   'mobile': '$mobile',
              //   'country_id': '$countryId',
              //   'city_id': '$cityId',
              //   'gender': '$gender',
              //   'nationality_id': '$nationalityId',
              //   'category': '$category',
              //   'user_name': '$userName',
              //   'info': '$info',
              //   'avatar': '$image',
              //   'description': '$description',
              //   'experience_year': '$experienceYear',
              //   'document[]': '$documents',
              //   'bank_name': '$bankName',
              //   'bank_account': '$bankAccount',
              //   'birthday': '$birthday',
              // });
              body: {
            'email': 'aki@ljddhul.sa',
            'password': '12645679',
            'full_name': 'Ahmggeggd',
            'mobile': '+9665258855520',
            'country_id': '1',
            'city_id': '1',
            'gender': "1",
            'nationality_id': "1",
            'category': "19",
            'user_name': 'lkjhhddlk',
            'info': '11111',
            'avatar': '$image',
            'description': '2',
            'experience_year': '1',
            'document[]': '2',
            'bank_name': '2',
            'bank_account': '2',
            'birthday': '2',
          });

      Map<String, dynamic> responseMap = json.decode(response.body);

      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = registerModelFromJson(response.body);

        // sharedPrefs.setToken(userdata.data!.token!);
        // sharedPrefs.setUserName(userdata.data!.userName!);
        // if (userdata.data!.avatar != "") {
        //   sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        // } else {
        //   sharedPrefs.setUserPhoto('');
        // }
        return userdata;
      } else {
        MyApplication.showToastView(message: responseMap["message"].toString());
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
