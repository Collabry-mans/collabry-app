import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.image, this.radius = 28});
  final String image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.white,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: image,
          height: 2 * radius,
          width: 2 * radius,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            Assets.imagesProfileAvatar,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
