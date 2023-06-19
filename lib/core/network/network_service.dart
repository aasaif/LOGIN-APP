import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../api/api_end_points.dart';
import '../helper/logger.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  static header() => {"Content-Type": "application/json", 'Accept': "application/json"};

  Future<HttpService> init() async {
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoint.baseUrl, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          logger.i("REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          logger.i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request({required String url, required Method method, Map<String, dynamic>? params, String? authToken}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url, data: params, options: Options(headers: {"Authorization": authToken}));
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params, options: Options(headers: {"Authorization": authToken}));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 422) {
        Get.snackbar('Error', response.data['message']);
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (e) {
      logger.e(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      logger.e(e);
      if (e.type == DioErrorType.other) {
        Get.snackbar('Opps', "There is no internet connection");
      } else if (e.type == DioErrorType.cancel) {
        Get.snackbar('Opps', "Request to API server was cancelled");
      } else if (e.type == DioErrorType.connectTimeout) {
        Get.snackbar('Opps', "Connection timeout with API server");
      } else if (e.type == DioErrorType.receiveTimeout) {
        Get.snackbar('Opps', "Receive timeout in connection with API server");
      } else if (e.type == DioErrorType.sendTimeout) {
        Get.snackbar('Opps', "Send timeout in connection with API server");
      } else if (e.type == DioErrorType.response) {
        print(e.response);
        Get.snackbar('Opps', e.response?.data['message']);
      }
      throw Exception(e);
      throw Exception(e);
    } catch (e) {
      logger.e(e);
      throw Exception("Something went wrong");
    }
  }
}
