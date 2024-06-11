// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart' as Dio;
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:http_parser/http_parser.dart';
// import '../../../app/utils/my_application.dart';
// import '../../app/utils/dio.dart';
//
// class SendChatRepo {
//   Future<bool?> sendChat({
//     String? msg,
//     String? adviceId,
//     File? file,
//   }) async {
//     String fileName = file?.path.split('/').last ?? "";
//     String? mimeType = mime(fileName);
//     String mimee = mimeType!.split('/')[0];
//     String type = mimeType.split('/')[1];
//
//     FormData formData = FormData.fromMap({
//       if (file != null)
//         "chat_document[0]": await MultipartFile.fromFile(file.path,
//             filename: fileName.contains("mp3") ? fileName + ".mp3" : fileName,
//             contentType: MediaType(mimee, type)
//             // contentType: MediaType("audio", "mpeg"),
//
//             ),
//       if (msg != "" && msg != null) 'message': msg,
//       'advice_id': '$adviceId',
//     });
//
//     log(
//         {
//           if (file != null) "chat_document[0]": file.path,
//           // await MultipartFile.fromFile(file.path, filename: fileName),
//           if (msg != "" && msg != null) 'message': msg,
//           'advice_id': '$adviceId',
//         }.toString(),
//         name: "Sent Request");
//
//     log(file?.path.split('/').last.toString() ?? "", name: "Sent Request");
//     try {
//       Dio.Response response = await dio().post(
//         '/adviser/chat/store',
//         data: formData,
//       );
//       if (response.statusCode == 200 && response.data["status"] == 1) {
//         debugPrint(response.data.toString());
//         return true;
//       } else {
//         MyApplication.showToastView(
//             message: response.data["message"].values.toString());
//       }
//     } on TimeoutException catch (e, st) {
//       log(st.toString(), name: "First");
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on SocketException catch (e, st) {
//       log(st.toString(), name: "Second");
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on Error catch (e, st) {
//       log(st.toString(), name: "Third");
//       if (kDebugMode) {
//         print(e);
//         MyApplication.showToastView(message: e.toString());
//       }
//     }
//     return null;
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'dart:io';
// import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import '../../../app/utils/my_application.dart';
import '../../app/utils/dio.dart';
import '../../app/utils/shared_preference.dart';

class SendChatRepo {
  Future<bool?> sendChat({
    File? file,
    String? msg,
    String? adviceId,
  }) async {
    try {
      String apiURL = "https://uat.nasoh.app/Admin";
      String uri = "$apiURL/adviser/chat/store";

      String fileName = file?.path.split('/').last ?? "";
      String? mimeType = mime(fileName);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      print(fileName);

      FormData data = FormData.fromMap({
        if (file != null)
          "chat_document[0]": await MultipartFile.fromFile(
            file.path,
            filename: fileName.contains("mp3") ? fileName + ".mp3" : fileName,
            contentType: MediaType(mimee, type),
          ),
        if (msg != "" && msg != null) 'message': msg,
        'advice_id': '$adviceId',
      });


      //     log(
//         {
//           if (file != null) "chat_document[0]": file.path,
//           // await MultipartFile.fromFile(file.path, filename: fileName),
//           if (msg != "" && msg != null) 'message': msg,
//           'advice_id': '$adviceId',
//         }.toString(),
//         name: "Sent Request");
//
//     log(file?.path.split('/').last.toString() ?? "", name: "Sent Request");

      Dio dio = Dio(BaseOptions(headers: {
        'Authorization': "Bearer ${sharedPrefs.getToken}",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }, contentType: "application/json"));
      var response = await dio.post(uri, data: data);
      if (response.statusCode == 200 && response.data["status"] == 1) {
        debugPrint(response.data.toString());
        return true;
      } else {
        MyApplication.showToastView(
            message: response.data["message"].values.toString());
      }
    } on TimeoutException catch (e, st) {
      log(st.toString(), name: "First");
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e, st) {
      log(st.toString(), name: "Second");
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e, st) {
      log(st.toString(), name: "Third");
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
