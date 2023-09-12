import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularNetworkImage extends StatelessWidget {
  const CircularNetworkImage(
      {super.key, required this.imageLink, this.radius = 20.0});
  final String imageLink;
  final double radius;
  @override
  Widget build(BuildContext context) {
    // Use below to implement Hero animation for profile picture
    //https: //docs.flutter.dev/ui/animations/hero-animations
    return CachedNetworkImage(
      imageUrl: imageLink,
      placeholder: (context, url) => CircleAvatar(
        radius: radius,
        foregroundImage: const AssetImage(
          'assets/default_avatar.png',
        ),
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        foregroundImage: imageProvider,
      ),
    );
  }
}
