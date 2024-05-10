import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    required this.imageLink,
    this.radius = 20.0,
    this.expandOnTap = false,
    this.blurSigma = 1.75,
  });

  final String imageLink;
  final double radius;
  final bool expandOnTap;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    // Use below to implement Hero animation for profile picture
    //https: //docs.flutter.dev/ui/animations/hero-animations

    return expandOnTap
        ? Stack(children: [
            getWidgetBasedOnImageType(),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: blurSigma, sigmaY: blurSigma),
                      child: SimpleDialog(
                        backgroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        insetPadding: const EdgeInsets.all(8),
                        children: [
                          getWidgetBasedOnImageType(
                              radius: (min(MediaQuery.of(context).size.width,
                                          MediaQuery.of(context).size.height) -
                                      32) /
                                  2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ])
        : getWidgetBasedOnImageType();
  }

  Widget getWidgetBasedOnImageType({double? radius}) {
    return imageLink.contains('http')
        ? CachedNetworkUserCircularImage(
            radius: radius ?? this.radius, imageLink: imageLink)
        : AssetUserCircularImage(
            radius: radius ?? this.radius, imageLink: imageLink);
  }
}

class AssetUserCircularImage extends StatelessWidget {
  const AssetUserCircularImage({
    super.key,
    required this.radius,
    required this.imageLink,
  });

  final double radius;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: AssetImage(
        imageLink,
      ),
    );
  }
}

class CachedNetworkUserCircularImage extends StatelessWidget {
  const CachedNetworkUserCircularImage({
    super.key,
    required this.imageLink,
    required this.radius,
  });

  final String imageLink;
  final double radius;

  @override
  Widget build(BuildContext context) {
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
