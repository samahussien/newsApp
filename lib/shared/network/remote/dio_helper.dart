import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String Url, required Map<String, dynamic> query}) async {
    late Response<dynamic> result;
    try {
      result = await dio.get(Url, queryParameters: query);
    } catch (exception) {
      print('error happend,sama $exception');
    }
    return result;
  }
}
