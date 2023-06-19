import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:login_app/core/api/api_end_points.dart';
import 'package:login_app/core/helper/logger.dart';
import 'package:login_app/model/user_list_model.dart';

import '../core/network/network_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  HttpService httpService = HttpService();
  var userList = [].obs;
  var selectedProfileIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    httpService.init();
    getUserList();
  }

  getUserList() async {
    try {
      isLoading(true);
      final result = await httpService.request(url: ApiEndpoint.userList, method: Method.GET);
      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;

          userList(jsonResponse['data']);

          logger.d(userList);

          isLoading(false);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
