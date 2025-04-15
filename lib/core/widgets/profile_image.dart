import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {super.key,
      required this.image,
      this.width = 54,
      this.height = 54,
      this.radius = 28});
  final String image;
  final double width, height, radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.txtColor,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: image,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            Assets.imagesProfileAvatar,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
