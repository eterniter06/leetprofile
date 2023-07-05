import 'package:flutter/material.dart';

class CircularNetworkImage extends StatelessWidget {
  const CircularNetworkImage({super.key, required this.imageLink});
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    // Use below to implement Hero animation for profile picture
    //https: //docs.flutter.dev/ui/animations/hero-animations
    return CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(
        imageLink,
      ),
    );
  }
}
