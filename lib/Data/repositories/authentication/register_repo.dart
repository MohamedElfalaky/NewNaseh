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
            'avatar[0][file]': '$avatar',
            'document': documents,
            'device': sharedPrefs.fCMToken,
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final userdata = registerModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setUserName(userdata.data!.userName!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        MyApplication.showToastView(message: responseMap["message"]);
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
}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nasooh/app/global.dart';
// import 'package:nasooh/app/keys.dart';
// import '../../../app/utils/myApplication.dart';
// import '../../../app/utils/sharedPreferenceClass.dart';
// import '../../../dio..dart';
// import '../../models/Auth_models/register_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart' as Dio;
//
// class Register {
//   Future<RegisterModel?> register(
//       {String? email,
//       String? pass,
//       String? fullName,
//       String? mobile,
//       String? countryId,
//       String? cityId,
//       int? gender,
//       String? nationalityId,
//       String? category,
//       String? userName,
//       String? info,
//       String? description,
//       String? experienceYear,
//       String? documents,
//       String? bankName,
//       String? bankAccount,
//       String? birthday,
//       XFile? avatar}) async {
//     try {
//       File imageFile = File(avatar!.path);
//       var stream = http.ByteStream(imageFile.openRead());
//       var length = await imageFile.length();
//       var uri = Uri.parse('${Keys.baseUrl}/adviser/auth/store');
//       var request = http.MultipartRequest('POST', uri);
//       var multipartFile = http.MultipartFile('avatar', stream, length,
//           filename: imageFile.path.split('/').last);
//       request.files.add(multipartFile);
//       request.headers.addAll(GlobalVars().headers!);
//       request.fields.addAll({
//         'email': '$email',
//         // 'email': 'ahmedali@jdj.edscxk',
//         'password': '$pass',
//         'full_name': '$fullName',
//         'mobile': '$mobile',
//         // 'mobile': '+966528965425',
//         'country_id': '$countryId',
//         'city_id': '$cityId',
//         'gender': '$gender',
//         'nationality_id': '$nationalityId',
//         'category': '$category',
//         'user_name': '$userName',
//         // 'user_name': 'wdfksgvjhsacxbz ascxnbbbbbjh',
//         'info': '$info',
//         'description': '$description',
//         'experience_year': '$experienceYear',
//         'document[]': '$documents',
//         'bank_name': '$bankName',
//         'bank_account': '$bankAccount',
//         'birthday': '$birthday',
//       });
//
//       print(request.files.toString());
//       var streamedResponse = await request.send();
//       http.Response response = await http.Response.fromStream(streamedResponse);
//       // print("response is ${response}");
//
//       // http.Response response =
//       //     await http.post(Uri.parse('${Keys.baseUrl}/adviser/auth/store'),
//       //         headers: GlobalVars().headers,
//       //         // body:
//
//       print(response.body);
//       print(response.statusCode);
//       // print( json.decode(response.body)["status"]);
//       Map<String, dynamic> responseMap = json.decode(response.body);
//       print("responseMap.toString() ${responseMap.toString()}");
//       if (response.statusCode == 200 && responseMap["status"] == 1) {
//         print(response.body);
//         final userdata = registerModelFromJson(responseMap);
//         sharedPrefs.setToken(userdata.data!.token!);
//         sharedPrefs.setUserName(userdata.data!.userName!);
//         if (userdata.data!.avatar != "") {
//           sharedPrefs.setUserPhoto(userdata.data!.avatar!);
//         } else {
//           sharedPrefs.setUserPhoto('');
//         }
//         // MyApplication.showToastView(message: responseMap["message"]);
//         return userdata;
//       } else {
//         // debugPrint("request is $phone & $pass");
//         MyApplication.showToastView(
//             // message: responseMap["message"].values.toString());
//             message: responseMap["message"].toString());
//       }
//     } on TimeoutException catch (e) {
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on SocketException catch (e) {
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on Error catch (e) {
//       if (kDebugMode) {
//         print(e);
//         MyApplication.showToastView(message: e.toString());
//       }
//     }
//     return null;
//   }
// }
//
// // ///=======talabatkom Code ===================================
//
// //
// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/foundation.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:nasooh/app/global.dart';
// // import 'package:nasooh/app/keys.dart';
// // import '../../../app/utils/myApplication.dart';
// // import '../../../app/utils/sharedPreferenceClass.dart';
// // import '../../../dio..dart';
// // import '../../models/Auth_models/register_model.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:dio/dio.dart' as Dio;
// //
// //
// // class Register {
// //   Future<RegisterModel?> register(
// //       {String? email,
// //       String? pass,
// //       String? fullName,
// //       String? mobile,
// //       String? countryId,
// //       String? cityId,
// //       int? gender,
// //       String? nationalityId,
// //       String? category,
// //       String? userName,
// //       String? info,
// //       String? description,
// //       String? experienceYear,
// //       String? documents,
// //       String? bankName,
// //       String? bankAccount,
// //       String? birthday,
// //       XFile? avatar}) async {
// //     File? image;
// //     try {
// //       var request = http.MultipartRequest(
// //           'POST', Uri.parse('${Keys.baseUrl}/adviser/auth/store'));
// //
// //       Map<String, String> headers = {
// //         'Accept': 'application/json',
// //         'lang': selectedLang!,
// //       };
// //
// //       request.headers.addAll(headers);
// //       request.fields['email'] = email!;
// //       request.fields['password'] = pass!;
// //       request.fields['full_name'] = fullName!;
// //       request.fields['mobile'] = mobile!;
// //       request.fields['country_id'] = countryId!;
// //       request.fields['city_id'] = cityId!;
// //       request.fields['gender'] = gender.toString();
// //       request.fields['nationality_id'] = nationalityId!;
// //       request.fields['category'] = category!;
// //       request.fields['user_name'] = userName!;
// //       request.fields['info'] = info!;
// //       request.fields['description'] = description!;
// //       request.fields['experience_year'] = experienceYear!;
// //       request.fields['document[]'] = documents!;
// //       request.fields['bank_name'] = bankName!;
// //       request.fields['bank_account'] = bankAccount!;
// //       request.fields['birthday'] = birthday!;
// //
// //       // request.fields['email'] = "ahmedi@yi.lk";
// //       // request.fields['password'] = "hjhjhjhjk";
// //       // request.fields['full_name'] = "bjsdbsdbbjsdbmsdbmsdbsdsbmdbmsdbmsd";
// //       // request.fields['mobile'] = "+966589964133";
// //       // request.fields['country_id'] = "1";
// //       // request.fields['city_id'] = "19";
// //       // request.fields['gender'] = "0";
// //       // request.fields['nationality_id'] = "1";
// //       // request.fields['category'] = "20";
// //       // request.fields['user_name'] = "ghasggaskvvahjsvssdnsj,jnsdjns";
// //       // request.fields['info'] = "new";
// //       // request.fields['description'] = 'description';
// //       // request.fields['experience_year'] = 'experienceYear';
// //       // request.fields['document[]'] = 'documents';
// //       // request.fields['bank_name'] = 'bankName';
// //       // request.fields['bank_account'] = 'bankAccount';
// //       // request.fields['birthday'] = '52';
// //       if (image != null) {
// //         request.files
// //             .add(await http.MultipartFile.fromPath('avatar', avatar!.path));
// //         print("avatar!.path id ${avatar.path}");
// //       }
// //
// //       var response = await request.send();
// //
// //       Map<String, dynamic> responseMap;
// //       dynamic userdata;
// //       response.stream
// //           .transform(utf8.decoder)
// //           .transform(const LineSplitter())
// //           .listen((value) {
// //         Map<String, dynamic> responseMap = {};
// //         if (value.isNotEmpty) {
// //           responseMap = json.decode(value);
// //         }
// //
// //         print("value is ${value.toString()}");
// //         // responseMap = json.decode(value);
// //         print("responseMap.toString() is ${responseMap.toString()}");
// //
// //         if (response.statusCode == 200 && responseMap["status"] == 1) {
// //           userdata = registerModelFromJson(responseMap);
// //           print(responseMap.toString());
// //
// //           sharedPrefs.setUserName(userdata.data!.avatar!);
// //           MyApplication.showToastView(message: responseMap["message"]);
// //
// //           sharedPrefs.setToken(userdata.data!.token!);
// //           sharedPrefs.setUserName(userdata.data!.userName!);
// //           if (userdata.data!.avatar != "") {
// //             sharedPrefs.setUserPhoto(userdata.data!.avatar!);
// //           } else {
// //             sharedPrefs.setUserPhoto('');
// //           }
// //
// //           MyApplication.showToastView(
// //               message: responseMap["message"].toString());
// //
// //           // return true;
// //         } else {
// //           MyApplication.showToastView(
// //               message: responseMap["message"].toString());
// //         }
// //
// //         // return false;
// //       });
// //       return userdata;
// //     } on TimeoutException catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     } on SocketException catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     } on Error catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     }
// //   }
// // }
//
// ///======finished talabatkom code =====================
//
// // class Register {
// //   Future<RegisterModel?> register(
// //       {String? email,
// //       String? pass,
// //       String? fullName,
// //       String? mobile,
// //       String? countryId,
// //       String? cityId,
// //       int? gender,
// //       String? nationalityId,
// //       String? category,
// //       String? userName,
// //       String? info,
// //       String? description,
// //       String? experienceYear,
// //       String? documents,
// //       String? bankName,
// //       String? bankAccount,
// //       String? birthday,
// //       XFile? avatar}) async {
// //     var image;
// //     if (avatar != null) {
// //       image = Dio.MultipartFile.fromFileSync(avatar.path,
// //           filename: "${avatar.path.split('/').last}");
// //     }
// //
// //     try {
// //       Map<String, dynamic> map = {
// //         'email': email,
// //         // 'email': "aihnh@sa.miofjo",
// //         'password': pass,
// //         'full_name': fullName,
// //         'mobile': mobile,
// //         // 'mobile': "+966580845508",
// //         'country_id': countryId,
// //         'city_id': cityId,
// //         'gender': gender,
// //         'nationality_id': nationalityId,
// //         'category': category,
// //         'user_name': userName,
// //         // 'user_name': "ghgsudlgisdghsidsdfiifvjsdvsdbv",
// //         'info': '$info',
// //         'avatar': image,
// //         'description': '$description',
// //         'experience_year': '$experienceYear',
// //         'document[]': '$documents',
// //         'bank_name': '$bankName',
// //         'bank_account': '$bankAccount',
// //         'birthday': '$birthday',
// //       };
// //       print("image.toString() is ${image.toString()}");
// //       Dio.Response response = await dio().post(
// //         "/adviser/auth/store",
// //         data: Dio.FormData.fromMap(map),
// //       );
// //
// //       print(response.statusCode);
// //       print(response.data.toString());
// //       if (response.statusCode == 200) {
// //         return registerModelFromJson(response.data);
// //       }
// //     } on TimeoutException catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     } on SocketException catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     } on Error catch (e) {
// //       if (kDebugMode) {
// //         print(e);
// //       }
// //     }
// //   }
// // }
