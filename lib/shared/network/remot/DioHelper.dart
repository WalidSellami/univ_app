import 'package:dio/dio.dart';
class DioHelper{

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String , dynamic>? query,
    String? token,
}) async{

    dio?.options.headers = {
      'Authorization' : token,
    };


    return await dio?.get(url , queryParameters: query);

  }

  static Future<Response?> postData({
    required String url,
    required Map<String , dynamic> data,
    Map<String , dynamic>? query,
    String? token,
  }) async{

    dio?.options.headers = {
      'Authorization' : token,
    };


    return await dio?.post(url , data: data , queryParameters: query);

  }

  static Future<Response?> putData({
    required String url,
    required Map<String , dynamic> data,
    Map<String , dynamic>? query,
    String? token,
  }) async{

    dio?.options.headers = {
      'Authorization' : token,
    };


    return await dio?.put(url , data: data, queryParameters: query);

  }

  static Future<Response?> deleteData({
    required String url,
    Map<String , dynamic>? data,
    Map<String , dynamic>? query,
    String? token,
  }) async{

    dio?.options.headers = {
      'Authorization' : token,
    };


    return await dio?.delete(url , data: data , queryParameters: query);

  }

}