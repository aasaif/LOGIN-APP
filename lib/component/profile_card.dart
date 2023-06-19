import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.path,
    this.onTap,
  });
  final String name;
  final String path;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: path,
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
          Text(name),
        ],
      ),
    );
  }
}
