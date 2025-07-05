import 'package:url_launcher/url_launcher.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outLineInputBorder(double radius) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: const BorderSide(color: AppColors.white),
  );
}

Future<void> openSocialMedia(String? nativeUrl, String webUrl) async {
  final Uri nativeUri = Uri.parse(nativeUrl ?? '');
  final Uri webUri = Uri.parse(webUrl);

  if (await canLaunchUrl(nativeUri)) {
    await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
  } else {
    await launchUrl(webUri, mode: LaunchMode.externalApplication);
  }
}
