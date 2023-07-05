import 'package:flutter/material.dart';

class SquircleNetworkImage extends StatelessWidget {
  const SquircleNetworkImage({super.key, required this.imageLink});

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.network(
          imageLink,
          fit: BoxFit.cover,
          semanticLabel: 'Profile picture',
          // ),
        ),
      ),
    );
  }
}
