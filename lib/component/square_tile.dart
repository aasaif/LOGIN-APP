import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 25,
      ),
    );
  }
}
