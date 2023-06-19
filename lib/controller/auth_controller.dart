import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../core/api/api_end_points.dart';
import '../core/network/network_service.dart';
import '../views/home.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  HttpService httpService = HttpService();

  @override
  void onInit() {
    super.onInit();
    httpService.init();
  }

  login({required String email, required String password}) async {
    try {
      isLoading(true);
      final result = await httpService.request(url: ApiEndpoint.login, method: Method.POST, params: {
        "email": email.toString(),
        "password": password.toString(),
      });
      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;
          var responseCode = result.statusCode;

          isLoading(false);

          if (responseCode == 200) {
            Get.to(Home());
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
