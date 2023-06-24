import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../../dio..dart';
import '../../models/Auth_models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;

class Register {
  Future<RegisterModel?> register(
      {String? email,
      String? pass,
      String? fullName,
      String? mobile,
      String? countryId,
      String? cityId,
      int? gender,
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
    try {
      File imageFile = File(avatar!.path);
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var uri = Uri.parse('${Keys.baseUrl}/adviser/auth/store');
      var request = http.MultipartRequest('POST', uri);
      var multipartFile = http.MultipartFile('avatar', stream, length,
          filename: imageFile.path.split('/').last);
      // request.files.add(multipartFile);
      request.headers.addAll(GlobalVars().headers!);
      request.fields.addAll({
        'email': '$email',
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
        'document[]': '$documents',
        'bank_name': '$bankName',
        'bank_account': '$bankAccount',
        'birthday': '$birthday',
      });
      print(request.files.toString());
      var streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      // print("response is ${response}");

      // http.Response response =
      //     await http.post(Uri.parse('${Keys.baseUrl}/adviser/auth/store'),
      //         headers: GlobalVars().headers,
      //         // body:

      print(response.body);
      print(response.statusCode);
      // print( json.decode(response.body)["status"]);
      Map<String, dynamic> responseMap = json.decode(response.body);
      print("responseMap.toString() ${responseMap.toString()}");
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final userdata = registerModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setUserName(userdata.data!.userName!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        // MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        // debugPrint("request is $phone & $pass");
        MyApplication.showToastView(
            // message: responseMap["message"].values.toString());
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

// Future<RegisterModel?> register(
//     {String? email,
//     String? pass,
//     String? fullName,
//     String? mobile,
//     String? countryId,
//     String? cityId,
//     int? gender,
//     String? nationalityId,
//     String? category,
//     String? userName,
//     String? info,
//     String? description,
//     String? experienceYear,
//     String? documents,
//     String? bankName,
//     String? bankAccount,
//     String? birthday,
//     XFile? avatar}) async {
//   var licence;
//   if (avatar != null) {
//     licence = Dio.MultipartFile.fromFileSync(avatar.path,
//         filename: avatar.path.split('/').last);
//   }
//   Map<String, dynamic> map = {
//     'email': 'Atiyyuh@ih.nae',
//     'password': 'yuAiAuhieudiAlid',
//     'full_name': 'fullname is ghdcvcv55jhcvjhc',
//     'mobile': '+966577788890',
//     'country_id': '5',
//     'city_id': '43',
//     'gender': '0',
//     'nationality_id': '1',
//     'category': '19',
//     'user_name': 'Amkn5ruueuookrfridde',
//     'info': 'sgxfgghcghchchg',
//     'description': '2222323',
//     'experience_year': '22',
//     'document[]': '222',
//     'bank_name': '',
//     "avatar": avatar,
//     'bank_account': '',
//     'birthday': '25-12',
//   };
//   print(map);
//   try {
//     Dio.Response response = await dio().post(
//       '/adviser/auth/store',
//       data: Dio.FormData.fromMap(map),
//       options: Dio.Options(
//         headers: GlobalVars().headers!,
//       ),
//     );
//     if (response.statusCode == 200) {
//       print(response.data);
//       final userdata = registerModelFromJson(response.data);
//       sharedPrefs.setToken(userdata.data!.token!);
//       sharedPrefs.setUserName(userdata.data!.userName!);
//       if (userdata.data!.avatar != "") {
//         sharedPrefs.setUserPhoto(userdata.data!.avatar!);
//       } else {
//         sharedPrefs.setUserPhoto('');
//       }
//       // MyApplication.showToastView(message: responseMap["message"]);
//       return userdata;
//     }
//
//     print(response.data);
//   } catch (error) {
//     rethrow;
//   }
// }
}
