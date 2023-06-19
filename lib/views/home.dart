import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/component/profile_card.dart';
import 'package:login_app/views/profile_info.dart';

import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
              itemCount: homeController.userList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Expanded(
                  child: ProfileCard(
                    onTap: () {
                      homeController.selectedProfileIndex(index);
                      Get.to(const ProfileInfo());
                    },
                    name: homeController.userList[index]['first_name'],
                    path: homeController.userList[index]['avatar'],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
