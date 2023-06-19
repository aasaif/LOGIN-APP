import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/controller/home_controller.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: homeController.userList[homeController.selectedProfileIndex.value]["avatar"].toString(),
            placeholder: (context, url) => const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
            ),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 30,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
              "Username:${homeController.userList[homeController.selectedProfileIndex.value]['first_name']} ${homeController.userList[homeController.selectedProfileIndex.value]['last_name']}"),
          SizedBox(
            height: 16,
          ),
          Text('Email : ${homeController.userList[homeController.selectedProfileIndex.value]['email']}'),
        ],
      ),
    );
  }
}
