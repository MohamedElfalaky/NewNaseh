import 'package:dio/dio.dart';
import 'app/global.dart';

Dio dio() {
  Dio dio = Dio();
  // dio.options.baseUrl = "https://maassetagenttenant.zamred.com/";
  // dio.options.baseUrl = "https://preprodassetagenttenant.zamred.com/";
  dio.options.baseUrl = 'https://nasoh.app/Admin';
  dio.options.connectTimeout = Duration(seconds: 2000);
  dio.options.headers.addAll({
    'Accept': 'application/json',
    'lang': selectedLang!,
  });

  dio.options.validateStatus = (status) {
    return status! < 499;
  };
  // dio.interceptors.add(
  //   LogInterceptor(
  //     responseBody: true,
  //     error: true,
  //     requestBody: true,
  //     requestHeader: true,
  //   ),
  // );
  return dio;
}
